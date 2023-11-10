class_name WaterComponent
extends Node

signal water_changed(val: float)
signal water_min_perfect_changed(val: float)
signal water_max_perfect_changed(val: float)
signal water_decrease_coef_changed(val: float)
signal water_decrease_value_changed(val: float)
signal water_increase_coef_changed(val: float)

const MIN: float = 0
const MAX: float = 100

@export_range(MIN, MAX) var water: float:
	set(new_value):
		water = clamp(new_value, MIN, MAX)
		water_changed.emit(water)


@export_category("Perfect")
@export_range(MIN, MAX) var min_perfect: float:
	set(new_value):
		min_perfect = new_value
		water_min_perfect_changed.emit(min_perfect)

@export_range(MIN, MAX) var max_perfect: float:
	set(new_value):
		max_perfect = new_value
		water_max_perfect_changed.emit(max_perfect)


@export_category("Decrease")
@export_range(0.1, 7.0, 0.1) var decrease_coef: float:
	set(new_value):
		decrease_coef = new_value
		water_decrease_coef_changed.emit(decrease_coef)

@export var decrease_value: float:
	set(new_value):
		decrease_value = new_value
		water_decrease_value_changed.emit(decrease_value)


@export_category("Increase")
@export_range(0.1, 7.0, 0.1) var increase_coef: float:
	set(new_value):
		increase_coef = new_value
		water_increase_coef_changed.emit(increase_coef)


@export var happiness_component: HappinessComponent


func _ready() -> void:
	_init_values()


#func _process(delta: float) -> void:
#	sub_water(delta, decrease_value)


func sub_water(delta: float, decr: float) -> void:
	water -= decr * decrease_coef * delta


func add_water(delta: float, incr: float) -> void:
	water += incr * increase_coef * delta


func _init_values() -> void:
	water = water
	min_perfect = min_perfect
	max_perfect = max_perfect
	decrease_coef = decrease_coef
	decrease_value = decrease_value
	increase_coef = increase_coef
