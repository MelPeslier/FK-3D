extends FlowerPhaseFiniteState


@export_category("Components")
@export var water_interactor_component: InteractableComponent
@export var happiness_component: HappinessComponent
@export var water_component: WaterComponent
@export var flower_data: FlowerData

@export_category("States")
@export var day: FiniteState


func _ready() -> void:
	flower_data.nearby_happ_decr_coef_changed.connect(_on_nearby_happ_decr_coef_changed)


func enter() -> void:
	water_interactor_component.alter_collision(false)


func exit() -> void:
	water_interactor_component.alter_collision(true)


func process_frame(delta: float) -> FiniteState:
	water_component.process_frame(delta)

	var new_happ_decr: float = remap(
			happiness_component.happiness,
			happiness_component.MIN,
			happiness_component.max_max,
			flower_data.min_nearby_happ_decr_coef,
			flower_data.max_nearby_happ_decr_coef
	)

	flower_data.nearby_happ_decr_coef = new_happ_decr

	if happiness_component.is_happ_max():
		for flower: Flower in parent.nearby_water_flowers:
			flower.happiness_component.add_happ(delta, flower_data.nearby_happ_val)
	return null


func on_day_start() -> FiniteState:
	flower_data.update_price(happiness_component.happiness)
	return day


func _on_nearby_happ_decr_coef_changed(old_value: float, new_value: float) -> void:
	for flower: Flower in parent.nearby_water_flowers:
		flower.happiness_component.alter_decrease_coef(old_value, new_value)
