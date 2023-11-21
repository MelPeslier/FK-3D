class_name FlowerData
extends Node

signal nearby_happ_decr_coef_changed(old_value: float, new_value: float)
signal nearby_happ_incr_coef_changed(old_value: float, new_value: float)
signal nearby_water_decr_coef_changed(old_value: float, new_value: float)
signal nearby_water_incr_coef_changed(old_value: float, new_value: float)
signal flower_name_changed(new_value: String)


@export var flower_name: String:
	set(new_value):
		flower_name = new_value
		flower_name_changed.emit(flower_name)

@export var sell_price: float
@export_group("Nearby Modifiers")
@export_subgroup("Happiness Decr")
@export var min_nearby_happ_decr_coef: float
@export var max_nearby_happ_decr_coef: float

@export_subgroup("Happiness Incr")
@export var min_nearby_happ_incr_coef: float
@export var max_nearby_happ_incr_coef: float

@export_subgroup("Water Decr")
@export var min_nearby_water_decr_coef: float
@export var max_nearby_water_decr_coef: float

@export_subgroup("Water Incr")
@export var min_nearby_water_incr_coef: float
@export var max_nearby_water_incr_coef: float


var nearby_happ_decr_coef: float:
	set(new_value):
		new_value = clamp(new_value, min_nearby_happ_decr_coef, max_nearby_happ_decr_coef)
		nearby_happ_decr_coef_changed.emit(nearby_happ_decr_coef, new_value)
		nearby_happ_decr_coef = new_value

var nearby_happ_incr_coef: float:
	set(new_value):
		new_value = clamp(new_value, min_nearby_happ_incr_coef, max_nearby_happ_incr_coef)
		nearby_happ_incr_coef_changed.emit(nearby_happ_incr_coef, new_value)
		nearby_happ_incr_coef = new_value

var nearby_water_decr_coef: float:
	set(new_value):
		new_value = clamp(new_value, min_nearby_water_decr_coef, max_nearby_water_decr_coef)
		nearby_water_decr_coef_changed.emit(nearby_water_decr_coef, new_value)
		nearby_water_decr_coef = new_value

var nearby_water_incr_coef: float:
	set(new_value):
		new_value = clamp(new_value, min_nearby_water_incr_coef, max_nearby_water_incr_coef)
		nearby_water_incr_coef_changed.emit(nearby_water_incr_coef, new_value)
		nearby_water_incr_coef = new_value


func _ready() -> void:
	flower_name = flower_name
	nearby_happ_decr_coef = nearby_happ_decr_coef
	nearby_happ_incr_coef = nearby_happ_incr_coef
	nearby_water_decr_coef = nearby_water_decr_coef
	nearby_water_incr_coef = nearby_water_incr_coef






