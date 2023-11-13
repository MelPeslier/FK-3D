class_name DisplayContent
extends PanelContainer

@export var happiness_component: HappinessComponent
@export var water_component: WaterComponent
@export var flower_data: FlowerData

@export var name_info: NameInfo
@export var happiness_info: HappinessInfo
@export var water_info: WaterInfo


func _ready() -> void:
	# Name
	flower_data.flower_name_changed.connect(_on_flower_name_changed)
	
	# Happiness
	happiness_component.happ_changed.connect(_on_happ_changed)
	happiness_component.happ_decr_coef_changed.connect(_on_happ_decr_coef_changed)
	happiness_component.happ_decr_value_changed.connect(_on_happ_decr_value_changed)
	happiness_component.happ_incr_coef_changed.connect(_on_happ_incr_coef_changed)
	happiness_component.happ_incr_value_changed.connect(_on_happ_incr_value_changed)
	
	# Water
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
func _on_happ_changed(val: float) -> void:
	happiness_info.set_happ_label(val)


func _on_happ_decr_coef_changed(val: float) -> void:
	happiness_info.set_happ_decr_coef(val)


func _on_happ_decr_value_changed(val: float) -> void:
	happiness_info.set_happ_decr_value(val)


func _on_happ_incr_coef_changed(val: float) -> void:
	happiness_info.set_happ_incr_coef(val)


func _on_happ_incr_value_changed(val: float) -> void:
	happiness_info.set_happ_incr_value(val)


# Water

func _on_water_changed(val: float) -> void:
	water_info.set_water_label(val)


func _on_water_min_perfect_changed(val: float) -> void:
	water_info.set_water_min_perfect_label(val)


func _on_water_max_perfect_changed(val: float) -> void:
	water_info.set_water_max_perfect_label(val)


func _on_water_decrease_coef_changed(val: float) -> void:
	water_info.set_water_decr_coef_label(val)


func _on_water_decrease_value_changed(val: float) -> void:
	water_info.set_water_decr_value_label(val)


func _on_water_increase_coef_changed(val: float) -> void:
	water_info.set_water_incr_coef_label(val)


# Animation state
