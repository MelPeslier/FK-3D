class_name WaterComponent
extends Node

signal water_max_changed(val: float, min_max: float, max_max: float)
signal water_changed(val: float, val_min: float, val_max: float)
signal water_min_perfect_changed(val: float)
signal water_max_perfect_changed(val: float)
signal water_decrease_coef_changed(val: float)
signal water_decrease_value_changed(val: float)
signal water_increase_coef_changed(val: float)

const MIN: float = 0
const MAX: float = 100
const E := 0.001

@export_range(MIN, MAX) var water: float:
	set(new_value):
		water = clamp(new_value, MIN, MAX)
		water_changed.emit(water, MIN, MAX)


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
@export var decrease_coef: float = 1:
	set(new_value):
		decrease_coef = new_value
		water_decrease_coef_changed.emit(decrease_coef)

@export var decrease_value: float:
	set(new_value):
		decrease_value = new_value
		water_decrease_value_changed.emit(decrease_value)


@export_category("Increase")
@export var increase_coef: float = 1:
	set(new_value):
		increase_coef = new_value
		water_increase_coef_changed.emit(increase_coef)

@export_category("components")
@export var happiness_component: HappinessComponent

# Environment modifiers
const SUB_NEARBY: float = 1.0
const ADD_NEARBY: float = -0.5

const SUB_GROUND: float = 0.2
const ADD_GROUND: float = -0.1

var sub_env_modifier: float = 1
var add_env_modifier: float = 1


func _ready() -> void:
	_init_values()


func process_frame(delta: float) -> void:
	if water > E:
		sub_water(delta, decrease_value)
		if water > min_perfect and water < max_perfect:
			happiness_component.add_happ(delta)
		return
	
	happiness_component.sub_happ(delta)


func sub_water(delta: float, decr: float) -> void:
	water -= decr * decrease_coef * sub_env_modifier * delta


func add_water(delta: float, incr: float) -> void:
	water += incr * increase_coef * add_env_modifier * delta


func alter_decrease_coef(old_value: float, new_value: float) -> void:
	decrease_coef -= old_value
	decrease_coef += new_value


func alter_increase_coef(old_value: float, new_value: float) -> void:
	increase_coef -= old_value
	increase_coef += new_value


func alter_nearby(activate_malus: bool) -> void:
	if activate_malus:
		add_env_modifier += ADD_NEARBY
		sub_env_modifier += SUB_NEARBY
	else:
		add_env_modifier -= ADD_NEARBY
		sub_env_modifier -= SUB_NEARBY


func alter_ground(activate_malus: bool) -> void:
	if activate_malus:
		add_env_modifier += ADD_GROUND
		sub_env_modifier += SUB_GROUND
	else:
		add_env_modifier -= ADD_GROUND
		sub_env_modifier -= SUB_GROUND


func _init_values() -> void:
	water_max_changed.emit(MAX, MIN, MAX)
	water = water
	min_perfect = min_perfect
	max_perfect = max_perfect
	decrease_coef = decrease_coef
	decrease_value = decrease_value
	increase_coef = increase_coef
