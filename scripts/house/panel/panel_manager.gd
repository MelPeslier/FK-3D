extends Node3D

@export var cash_machine: CashMachine

func _ready() -> void:
	for panel: FlowerPanel in get_children():
		panel.cash_machine = cash_machine
