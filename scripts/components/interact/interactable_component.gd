class_name InteractableComponent
extends Area3D


@onready var collision_shape: CollisionShape3D = get_child(0)


signal focused(_interactor: InteractorComponent)

signal unfocused(_interactor: InteractorComponent)

signal interacted(_interactor: InteractorComponent)


func alter_collision(disable: bool) -> void:
	collision_shape.disabled = disable
