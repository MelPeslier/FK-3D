class_name WaterComponent
extends Node

const MIN: float = 0
const MAX: float = 100

@export_range(MIN, MAX) var water: float

@export_category("Perfect")
@export_range(MIN, MAX) var min_pefrect: float
@export_range(MIN, MAX) var max_perfect: float

@export_category("Decrease")
@export_range(0.1, 7.0, 0.1) var decrease_coef: float
@export var decrease_value: float

@export_category("Increase")
@export_range(0.1, 7.0, 0.1) var increase_coef: float


@export var happiness_component: HappinessComponent


func _process(delta: float) -> void:
	sub_water(delta, decrease_value)


func sub_water(delta: float, decr: float) -> void:
	water = max(water + decr * decrease_coef * delta, MIN)


func add_water(delta: float, incr: float) -> void:
	water = min(water + incr * increase_coef * delta, MAX)
