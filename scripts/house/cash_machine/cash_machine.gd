class_name CashMachine
extends Node3D

signal update_money(money: float)

var money: float:
	set(new_value):
		money = new_value
		update_money.emit(money)

@onready var label_3d: Label3D = $Label3D


func _ready() -> void:
	update_money.connect(_on_update_money)
	money = 0


func can_buy(price: float) -> bool:
	return price < money


func buy(price: float) -> void:
	money -= price


func sell(price: float) -> void:
	money += price


func steal(amount: float) -> float:
	var money_gone := minf(amount, money)
	money -= money_gone
	return money_gone


func _on_update_money(money: float) -> void:
	label_3d.text = "%.2f %s" % [money, "€"]
