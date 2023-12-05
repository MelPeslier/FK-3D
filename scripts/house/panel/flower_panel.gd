class_name FlowerPanel
extends Node3D

@export_file("*flower.tscn") var flower_scene_path : String

var flower_scene: PackedScene

var cash_machine: CashMachine

var seed_price: float = 0

@onready var nut_scene: PackedScene = preload("res://scenes/nut/nut.tscn")

@onready var label_name: Label3D = $LabelName
@onready var picture_sprite: Sprite3D = $PictureSprite
@onready var panel_price: PanelPrice = $PanelPrice as PanelPrice
@onready var spawn: Marker3D = $Spawn
@onready var label_price: Label3D = $PanelPrice/LabelPrice


func _ready() -> void:
	if flower_scene_path.is_empty(): return

	flower_scene = load(flower_scene_path)
	var flower: Flower = flower_scene.instantiate()
	picture_sprite.texture = load(flower.flower_data.picture_path)
	label_name.text = flower.flower_data.flower_name
	seed_price = flower.flower_data.seed_price


func _on_interactable_component_focused(_interactor: InteractorComponent) -> void:
	panel_price.visible = true

	var msg: String = ""
	if _interactor.controller is Player:
		msg = "buy for %.2f %s"
		if cash_machine.can_buy(seed_price):
			panel_price.appear(MyColor.can_buy)
		else:
			panel_price.appear(MyColor.can_not_buy)

		msg = msg  % [ seed_price, "€" ]

	elif _interactor.controller is Flower:
		msg = "sell for %.2f %s"
		panel_price.appear(MyColor.can_sell)

		msg = msg  % [ _interactor.controller.flower_data.seed_price, "€" ]

	label_price.text = msg


func _on_interactable_component_interacted(_interactor: InteractorComponent) -> void:
	if flower_scene_path.is_empty(): return

	if _interactor.controller is Player:
		if cash_machine.can_buy(seed_price):
			cash_machine.buy(seed_price)
			_give_flower(_interactor)

		else:
			_give_nut()

	elif _interactor.controller is Flower:
		cash_machine.sell(_interactor.controller.flower_data.seed_price)
		_interactor.controller.sold()


func _on_interactable_component_unfocused(_interactor: InteractorComponent) -> void:
	panel_price.disappear()


func _give_flower(_interactor: InteractorComponent) -> void:
	var flower_instance: Flower = flower_scene.instantiate() as Flower
	get_tree().get_root().add_child(flower_instance)
	flower_instance.global_position = spawn.global_position
	flower_instance.hold_interactable_component.interacted.emit(_interactor)


func _give_nut() -> void:
	var nut_instance: Nut = nut_scene.instantiate() as Nut
	get_window().add_child(nut_instance)
	nut_instance.global_position = spawn.global_position
