class_name HappinessComponent
extends Node


@export var value: float

@export_category("M I N")
@export var min_min: float
@export var min: float
@export var min_max: float

@export_category("M A X")
@export var max_min: float
@export var max: float
@export var max_max: float


func alter_min(incr: float) -> void:
	min = clamp(min + incr, min_min, min_max)


func alter_value(incr: float) -> void:
	value = clamp(value + incr, min, max)


func alter_max(incr: float) -> void:
	max = clamp(max + incr, max_min, max_max)




