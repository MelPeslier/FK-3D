class_name Flower
extends CharacterBody3D

signal dropped

@export_group("Components")
@export var in_game_ui: InGameUi
@export var happiness_component: HappinessComponent
@export var flower_data: FlowerData
@export var flower_detector: Area3D
@export var hold_interactable_component: InteractableComponent
@export var body_mesh: MeshInstance3D

# Variables
var holder: Node3D
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	hold_interactable_component.focused.connect(_on_hold_interactable_component_focused)
	hold_interactable_component.interacted.connect(_on_hold_interactable_component_interacted)
	hold_interactable_component.unfocused.connect(_on_hold_interactable_component_unfocused)


func modulate_item(_color: Color) -> void:
	# Only change the mesh albedo color
	var obj = body_mesh as MeshInstance3D
	var mat = obj.material_override as StandardMaterial3D
	mat.albedo_color = _color


# Hold interactable
func _on_hold_interactable_component_focused(_interactor: InteractorComponent):
	modulate_item(Color.DIM_GRAY)


func _on_hold_interactable_component_interacted(_interactor: InteractorComponent):
	holder = _interactor.controller
	_interactor.item_received.emit(self)


func _on_hold_interactable_component_unfocused(_interactor: InteractorComponent):
	modulate_item(Color.WHITE)


# Player  transmit
func process_unhandled_input(event: InputEvent) -> void:
	pass


func _on_dropped() -> void:
	holder = null


# UI related
func show_ui(player: Player) -> void:
	in_game_ui.show_ui(player)


func hide_ui() -> void:
	in_game_ui.hide_ui()
