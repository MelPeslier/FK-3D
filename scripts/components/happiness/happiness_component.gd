class_name HappinessComponent
extends Node


@export var happiness: float

@export_category("M I N")
@export var min_min: float
@export var min_happ: float
@export var min_max: float

@export_category("M A X")
@export var max_min: float
@export var max_happ: float
@export var max_max: float


func alter_min(incr: float) -> void:
	min_happ = clamp(min_happ + incr, min_min, min_max)


func alter_value(incr: float) -> void:
	happiness = clamp(happiness + incr, min_happ, max_happ)


func alter_max(incr: float) -> void:
	max_happ = clamp(max_happ + incr, max_min, max_max)




