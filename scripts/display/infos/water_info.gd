class_name WaterInfo
extends VBoxContainer

@export var water_label: Label
@export var water_min_perfect_label: Label
@export var water_max_perfect_label: Label
@export var water_decr_coef_label: Label
@export var water_decr_value_label: Label
@export var water_incr_coef_label: Label


func set_water_label(val: float) -> void:
	water_label.text = _3f_string(val)


func set_water_min_perfect_label(val: float) -> void:
	water_min_perfect_label.text = _3f_string(val)


func set_water_max_perfect_label(val: float) -> void:
	water_max_perfect_label.text = _3f_string(val)


func set_water_decr_coef_label(val: float) -> void:
	water_decr_coef_label.text = _3f_string(val)


func set_water_decr_value_label(val: float) -> void:
	water_decr_value_label.text = _3f_string(val)


func set_water_incr_coef_label(val: float) -> void:
	water_incr_coef_label.text = _3f_string(val)


func _3f_string(val : float) -> String:
	var final: String = "%.2f" % val
	return final
