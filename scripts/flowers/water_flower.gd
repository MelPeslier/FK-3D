class_name WaterFlower
extends Flower

const MAX_NEARBY_FLOWERS: int = 3

@export_group("Components")
@export var water_interactable_component: InteractableComponent
@export var water_component: WaterComponent

# Variables
var flowers_affecting_this: Array[WaterFlower] = []
var nearby_water_flowers: Array[WaterFlower] = []
var _is_on_ground := false
var _too_much_nearby := false


func _ready() -> void:
	super()
	
	flower_detector.body_entered.connect(_on_flower_detector_body_entered)
	flower_detector.body_exited.connect(_on_flower_detector_body_exited)
	
	water_interactable_component.focused.connect(_on_water_interactable_component_focused)
	water_interactable_component.interacted.connect(_on_water_interactable_component_interacted)
	water_interactable_component.unfocused.connect(_on_water_interactable_component_unfocused)


# Flower detector
func _on_flower_detector_body_entered(body: Node3D) -> void:
	if not body is WaterFlower: return
	if body == self: return
	
	nearby_water_flowers.append(body)
	
	var flower: WaterFlower = body as WaterFlower
	flower.start_being_affected_by(self)
	
	if not _too_much_nearby and nearby_water_flowers.size() > MAX_NEARBY_FLOWERS:
		_too_much_nearby = true
		water_component.alter_nearby(true)
		happiness_component.alter_nearby(true)
		flower_detector.appear_zone(true)


func _on_flower_detector_body_exited(body: Node3D) -> void:
	if not body is WaterFlower: return
	
	if body in nearby_water_flowers:
		nearby_water_flowers.erase(body)
		var flower: WaterFlower = body as WaterFlower
		# Reset affected coefs and put the self out of this array
		flower.stop_being_affected_by(self)
	
	if _too_much_nearby and nearby_water_flowers.size() <= MAX_NEARBY_FLOWERS:
		_too_much_nearby = false
		water_component.alter_nearby(false)
		happiness_component.alter_nearby(false)
		flower_detector.appear_zone(false)


func start_being_affected_by(flower: WaterFlower) -> void:
	flowers_affecting_this.append(flower)
	water_component.alter_decrease_coef(0, flower.flower_data.nearby_water_decr_coef)
	water_component.alter_increase_coef(0, flower.flower_data.nearby_water_incr_coef)
	happiness_component.alter_decrease_coef(0, flower.flower_data.nearby_happ_decr_coef)
	happiness_component.alter_increase_coef(0, flower.flower_data.nearby_happ_incr_coef)


func stop_being_affected_by(flower: WaterFlower) -> void:
	flowers_affecting_this.erase(flower)
	water_component.alter_decrease_coef(flower.flower_data.nearby_water_decr_coef, 0)
	water_component.alter_increase_coef(flower.flower_data.nearby_water_incr_coef, 0)
	happiness_component.alter_decrease_coef(flower.flower_data.nearby_happ_decr_coef, 0)
	happiness_component.alter_increase_coef(flower.flower_data.nearby_happ_incr_coef, 0)


# Interactable for watering can
func _on_water_interactable_component_focused(_interactor: InteractorComponent) -> void:
	modulate_item(Color.AQUA)


func _on_water_interactable_component_interacted(_interactor: InteractorComponent) -> void:
	_interactor.item_received.emit(self)


func _on_water_interactable_component_unfocused(_interactor: InteractorComponent) -> void:
	modulate_item(Color.WHITE)

