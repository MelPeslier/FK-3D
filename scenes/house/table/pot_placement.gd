class_name PotPlacement
extends Node3D

const color_focused := Color.DARK_GREEN
const color_unfocused := Color.GRAY

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var interactable_component: Area3D = $InteractableComponent
@onready var collision_shape_3d: CollisionShape3D = $InteractableComponent/CollisionShape3D


func _ready() -> void:
	set_color(color_unfocused)


func _on_interactable_component_focused(_interactor: InteractorComponent) -> void:
	set_color(color_focused)


func _on_interactable_component_interacted(_interactor: InteractorComponent) -> void:
	collision_shape_3d.disabled = true
	_interactor.item_unfocus.emit()
	_interactor.controller.global_transform = global_transform
	_interactor.item_received.emit(self)
	set_color(color_unfocused)


func _on_interactable_component_unfocused(_interactor: InteractorComponent) -> void:
	set_color(color_unfocused)


func reactivate() -> void:
	collision_shape_3d.disabled = false


func set_color(color: Color) -> void:
	mesh_instance_3d.set_instance_shader_parameter("albedo", color)
