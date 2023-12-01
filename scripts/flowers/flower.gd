class_name Flower
extends CharacterBody3D

signal dropped

@export_group("Components flower")
@export var happiness_component: HappinessComponent
@export var hold_interactable_component: InteractableComponent
@export var flower_interactor_component: FlowerInteractorComponent
@export var flower_data: FlowerData

@export_group("Nodes")
@export var animator: AnimationPlayer
@export var in_game_ui: InGameUi
@export var flower_detector: Area3D
@export var body_meshs: Array[MeshInstance3D]
@export var flower_phase_state_machine: FiniteStateMachine

# Variables
var holder: Node3D
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	hold_interactable_component.focused.connect(_on_hold_interactable_component_focused)
	hold_interactable_component.interacted.connect(_on_hold_interactable_component_interacted)
	hold_interactable_component.unfocused.connect(_on_hold_interactable_component_unfocused)

	flower_interactor_component.item_unfocus.connect(_on_flower_interactor_component_item_unfocus)
	flower_interactor_component.item_received.connect(_on_flower_interactor_component_item_received)

	flower_phase_state_machine.init(self)


#region Phase State Machine
func _physics_process(delta: float) -> void:
	flower_phase_state_machine.process_physics(delta)
	if not is_on_floor():
		velocity.y -= gravity
	else:
		velocity = _update_direction(delta, velocity, Vector3.ZERO, 4.5)

	move_and_slide()


func _process(delta: float) -> void:
	flower_phase_state_machine.process_frame(delta)
#endregion


#region Physics functions
func _update_direction(delta: float, direction: Vector3, target_direction: Vector3, coef: float) -> Vector3:
	var new_direction := direction.lerp(target_direction, delta * coef)
	return new_direction
#endregion


#region Modulate on hold
func modulate_item(_color: Color) -> void:
	# Only change the mesh albedo color
	var new_mat := StandardMaterial3D.new()
	new_mat.albedo_color = _color
	for mesh: MeshInstance3D in body_meshs:
		mesh.material_override = new_mat


func modulate_back() -> void:
	for mesh: MeshInstance3D in body_meshs:
		mesh.material_override = null
#endregion


#region Hold interactable
func _on_hold_interactable_component_focused(_interactor: InteractorComponent) -> void:
	modulate_item(Color.DIM_GRAY)


func _on_hold_interactable_component_interacted(_interactor: InteractorComponent) -> void:
	if holder:
		if holder is PotPlacement:
			holder.reactivate()

	holder = _interactor.controller
	_interactor.item_received.emit(self)
	modulate_back()


func _on_hold_interactable_component_unfocused(_interactor: InteractorComponent) -> void:
	modulate_back()
#endregion


#region ON Hold player and drop
func process_unhandled_input(event: InputEvent) -> void:
	flower_interactor_component.process_unhandled_input(event)


func process_physics_player(delta: float) -> void:
	flower_interactor_component.process_physics(delta)


func _on_flower_interactor_component_item_unfocus() -> void:
	holder.drop_item.emit()


func _on_flower_interactor_component_item_received(obj: Node3D) -> void:
	holder = obj


func _on_dropped() -> void:
	holder = null
#endregion


#region UI related
func show_ui(player: Player) -> void:
	in_game_ui.show_ui(player)


func hide_ui() -> void:
	in_game_ui.hide_ui()
#endregion

