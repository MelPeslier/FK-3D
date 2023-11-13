class_name FlowerData
extends Node

signal flower_name_changed(val: String)

@export var flower_name: String:
	set(val):
		flower_name = val
		flower_name_changed.emit(flower_name)

@export var sell_price: float

func _ready() -> void:
	flower_name = flower_name
