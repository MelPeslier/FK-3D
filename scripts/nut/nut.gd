class_name Nut
extends RigidBody3D


@export var rand_linear_velocity_x: float = 3.0
@export var rand_linear_velocity_y: float = 3.0
@export var rand_linear_velocity_z: float = 3.0


@onready var animator: AnimationPlayer = $Animator
@onready var timer: Timer = $Timer


func _ready() -> void:
	animator.play("APPEAR")




func apply_rand_forces() -> void:
	linear_velocity = Vector3(
			randf_range(-rand_linear_velocity_x, rand_linear_velocity_x),
			randf_range(-rand_linear_velocity_y, rand_linear_velocity_y),
			randf_range(-rand_linear_velocity_z, rand_linear_velocity_z)
	)


func _on_timer_timeout() -> void:
	queue_free()
