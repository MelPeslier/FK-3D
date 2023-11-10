class_name HappinessInfo
extends VBoxContainer

@export var happ_label: Label
@export var happ_decr_coef_label: Label
@export var happ_decr_value_label: Label
@export var happ_incr_coef_label: Label
@export var happ_incr_value_label: Label


func set_happ_label(val: float) -> void:
	happ_label.text = _3f_string(val)


func set_happ_decr_coef(val: float) -> void:
	happ_decr_coef_label.text = _3f_string(val)


func set_happ_decr_value(val: float) -> void:
	happ_decr_value_label.text = _3f_string(val)


func set_happ_incr_coef(val: float) -> void:
	happ_incr_coef_label.text = _3f_string(val)


func set_happ_incr_value(val: float) -> void:
	happ_incr_value_label.text = _3f_string(val)


func _3f_string(val : float) -> String:
	var final: String = "%.2f" % val
	return final
