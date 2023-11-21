class_name Flower
extends CharacterBody3D


@export_group("Components")
@export var in_game_ui: InGameUi
@export var happiness_component: HappinessComponent
@export var flower_data: FlowerData
@export var flower_detector: Area3D
@export var interactable_component: InteractableComponent

# Variables
var nearby_water_flowers: Array[WaterFlower]


func _ready() -> void:
	interactable_component.focused.connect(_on_interactable_component_focused)
	interactable_component.interacted.connect(_on_interactable_component_interacted)
	interactable_component.unfocused.connect(_on_interactable_component_unfocused)
	
	flower_detector.body_entered.connect(_on_flower_detector_body_entered)
	flower_detector.body_exited.connect(_on_flower_detector_body_exited)


# Interactable 
func _on_interactable_component_focused(_interactor: InteractorComponent) -> void:
	_interactor.item_received.emit(self)


func _on_interactable_component_interacted(_interactor: InteractorComponent) -> void:
	pass # Replace with function body.


func _on_interactable_component_unfocused(_interactor: InteractorComponent) -> void:
	pass


# Flower detector
func _on_flower_detector_body_entered(body: Node3D) -> void:
	if not body is WaterFlower: return
	if body == self: return
#	if (body.global_position - global_position).length() < 0.0001 : return
	
	nearby_water_flowers.append(body)


func _on_flower_detector_body_exited(body: Node3D) -> void:
	if not body is WaterFlower: return
	
	if body in nearby_water_flowers:
		nearby_water_flowers.erase(body)
		var flower: WaterFlower = body as WaterFlower
		flower.flowers_affecting_this.erase(self)


# Player interactor + transmit
func process_unhandled_input(event: InputEvent) -> void:
	pass


# UI related
func show_ui(player: Player) -> void:
	in_game_ui.show_ui(player)


func hide_ui() -> void:
	in_game_ui.hide_ui()
