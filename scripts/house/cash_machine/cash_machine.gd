extends Node3D

@export var game_data: GameData

@onready var label_3d: Label3D = $Label3D


func _ready() -> void:
	game_data.update_money.connect(_on_update_money)


func _on_update_money(money: float) -> void:
	print("money received" + str(money) )
	label_3d.text = "%.2f %s" % [money, "€"]
