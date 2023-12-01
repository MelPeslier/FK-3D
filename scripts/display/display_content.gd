class_name DisplayContent
extends PanelContainer

@export var happiness_component: HappinessComponent
@export var water_component: WaterComponent
@export var flower_data: FlowerData

@export var name_info: NameInfo
@export var water_info: InfoData
@export var happiness_info: InfoData


func _ready() -> void:
	# Name
	flower_data.flower_name_changed.connect(_on_flower_name_changed)

	# Happiness
	happiness_component.happ_max_changed.connect(_on_happ_max_changed)
	happiness_component.happ_changed.connect(_on_happ_changed)
	happiness_component.happ_decr_coef_changed.connect(_on_happ_decr_coef_changed)
	happiness_component.happ_decr_value_changed.connect(_on_happ_decr_value_changed)
	happiness_component.happ_incr_coef_changed.connect(_on_happ_incr_coef_changed)
	happiness_component.happ_incr_value_changed.connect(_on_happ_incr_value_changed)

	# Water
	water_component.water_max_changed.connect(_on_water_max_changed)
	water_component.water_changed.connect(_on_water_changed)
	water_component.water_min_perfect_changed.connect(_on_water_min_perfect_changed)
	water_component.water_max_perfect_changed.connect(_on_water_max_perfect_changed)
	water_component.water_decrease_coef_changed.connect(_on_water_decrease_coef_changed)
	water_component.water_decrease_value_changed.connect(_on_water_decrease_value_changed)
	water_component.water_increase_coef_changed.connect(_on_water_increase_coef_changed)


	# Animation state


# Name
func _on_flower_name_changed(val: String) -> void:
	name_info.set_obj_name(val)


# Happiness
func _on_happ_max_changed(val: float, val_min: float, val_max: float) -> void:
	happiness_info.set_max_value(val, val_min, val_max)


func _on_happ_changed(val: float, val_min: float, val_max: float) -> void:
	happiness_info.set_value(val, val_min, val_max)


func _on_happ_decr_coef_changed(val: float) -> void:
	happiness_info.set_decr_coef(val)


func _on_happ_decr_value_changed(val: float) -> void:
	happiness_info.set_decr_value(val)


func _on_happ_incr_coef_changed(val: float) -> void:
	happiness_info.set_incr_coef(val)


func _on_happ_incr_value_changed(val: float) -> void:
	happiness_info.set_incr_value(val)


# Water
func _on_water_max_changed(val: float, val_min: float, val_max: float) -> void:
	water_info.set_max_value(val, val_min, val_max)


func _on_water_changed(val: float, val_min: float, val_max: float) -> void:
	water_info.set_value(val, val_min, val_max)


func _on_water_min_perfect_changed(val: float) -> void:
	water_info.set_min_perfect(val)


func _on_water_max_perfect_changed(val: float) -> void:
	water_info.set_max_perfect(val)


func _on_water_decrease_coef_changed(val: float) -> void:
	water_info.set_decr_coef(val)


func _on_water_decrease_value_changed(val: float) -> void:
	water_info.set_decr_value(val)


func _on_water_increase_coef_changed(val: float) -> void:
	water_info.set_incr_coef(val)


# Animation state
