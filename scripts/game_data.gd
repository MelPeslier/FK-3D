class_name GameData
extends Node

signal update_money(money: float)

var money: float:
	set(new_value):
		money = new_value
		update_money.emit(money)


func _ready() -> void:
	print(money)
	money = 0.00001
	print(money)


func can_buy(price: float) -> bool:
	return price < money


func buy(price: float) -> void:
	money -= price


func sell(price: float) -> void:
	money += price
