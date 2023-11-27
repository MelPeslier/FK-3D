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
@export var flower_interactor_component: FlowerInteractorComponent

# Variables
var holder: Node3D
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	hold_interactable_component.focused.connect(_on_hold_interactable_component_focused)
	hold_interactable_component.interacted.connect(_on_hold_interactable_component_interacted)
	hold_interactable_component.unfocused.connect(_on_hold_interactable_component_unfocused)
	
	flower_interactor_component.item_unfocus.connect(_on_flower_interactor_component_item_unfocus)
	flower_interactor_component.item_received.connect(_on_flower_interactor_component_item_received)


func modulate_item(_color: Color) -> void:
	# Only change the mesh albedo color
	var obj = body_mesh as MeshInstance3D
	var mat = obj.material_override as StandardMaterial3D
	mat.albedo_color = _color


# Hold interactable
func _on_hold_interactable_component_focused(_interactor: InteractorComponent):
	modulate_item(Color.DIM_GRAY)


func _on_hold_interactable_component_interacted(_interactor: InteractorComponent):
	if holder:
		if holder is PotPlacement:
			holder.reactivate()
	
	holder = _interactor.controller
	_interactor.item_received.emit(self)
	modulate_item(Color.WHITE)


func _on_hold_interactable_component_unfocused(_interactor: InteractorComponent):
	modulate_item(Color.WHITE)


# Player  transmit
func process_unhandled_input(event: InputEvent) -> void:
	flower_interactor_component.process_unhandled_input(event)


func process_physics_player(delta: float) -> void:
	flower_interactor_component.process_physics(delta)


func _on_flower_interactor_component_item_unfocus() -> void:
	holder.drop_item.emit()


func _on_flower_interactor_component_item_received(obj):
	holder = obj


func _on_dropped() -> void:
	holder = null


# UI related
func show_ui(player: Player) -> void:
	in_game_ui.show_ui(player)


func hide_ui() -> void:
	in_game_ui.hide_ui()
