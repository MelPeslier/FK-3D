class_name FlowerPanel
extends Node3D

@export_file("*flower.tscn") var flower_scene_path : String

var flower_scene: PackedScene

# If false, means to sell
var _to_buy := true

var seed_price: float = 0

@onready var label_name: Label3D = $LabelName
@onready var picture_sprite: Sprite3D = $PictureSprite
@onready var panel_price: MeshInstance3D = $PanelPrice
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
		_to_buy = true
		msg = "buy for %.2f %s"
	elif _interactor.controller is Flower:
		_to_buy = false
		msg = "sell for %.2f %s"

	msg = msg  % [ seed_price, "€" ]
	label_price.text = msg


func _on_interactable_component_interacted(_interactor: InteractorComponent) -> void:
	if flower_scene_path.is_empty(): return

	if _to_buy:
		var instance: Flower = flower_scene.instantiate()
		get_tree().get_root().add_child(instance)
		instance.global_position = spawn.global_position
	else:
		return


func _on_interactable_component_unfocused(_interactor: InteractorComponent) -> void:
	panel_price.visible = false
