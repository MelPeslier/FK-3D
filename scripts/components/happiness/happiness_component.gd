class_name HappinessComponent
extends Node

signal happ_changed(val: float)
signal happ_decr_coef_changed(val: float)
signal happ_decr_value_changed(val: float)
signal happ_incr_coef_changed(val: float)
signal happ_incr_value_changed(val: float)

const MIN: float = 0
const MAX: float = 100


@export_range(MIN, MAX) var happiness: float:
	set(new_value):
		happiness = clamp(new_value, MIN, MAX)
		happ_changed.emit(happiness)


@export_category("Decrease")
@export_range(0.1, 7.0, 0.1) var decrease_coef: float:
	set(new_value):
		decrease_coef = new_value
		happ_decr_coef_changed.emit(decrease_coef)

@export var decrease_value: float:
	set(new_value):
		decrease_value = new_value
		happ_decr_value_changed.emit(decrease_value)


@export_category("Increase")
@export_range(0.1, 7.0, 0.1) var increase_coef: float:
	set(new_value):
		increase_coef = new_value
		happ_incr_coef_changed.emit(increase_coef)

@export var increase_value: float:
	set(new_value):
		increase_value = new_value
		happ_incr_value_changed.emit(increase_value)


func _ready() -> void:
	_init_values()


func _process(delta: float) -> void:
	sub_happ(delta)


func sub_happ(delta: float, decr: float = decrease_value) -> void:
	happiness -= decr * decrease_coef * delta


func add_happ(delta: float, incr: float) -> void:
	happiness += incr * increase_coef * delta


func _init_values() -> void:
	happiness = happiness
	decrease_coef = decrease_coef
	decrease_value = decrease_value
	increase_coef = increase_coef
	increase_value = increase_value
