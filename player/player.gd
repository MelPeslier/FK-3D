class_name Player
extends CharacterBody3D

@export_group("STATES")
@export_subgroup("Movements")
@export var movement_state_machine: FiniteStateMachine
@export var idle_state: State
@export var walk_state: State
@export var run_state: State

@export_group("PHYSICS")
@export_subgroup("Movements")
@export var gravity: float
@export var jump_strength: float
@export var accel: float
@export var max_speed: float
@export var sprint_speed: float
@export var walk_speed: float
@export var decel: float
@export_range(0.1, 10.0, 0.1) var ground_stop_coef: float
@export_range(0.1, 10.0, 0.1) var air_stop_coef: float

@export_group("JUICE")
@export_subgroup("Head movements")
@export var camera: Camera3D
@export var sensitivity: float
@export var head: Head
@export var head_frequency: float
@export var head_amplitude: float

@export_subgroup("Field of view")
@export var fov_change_coef: float
@export var fov_change_speed: float
@export var fov_min: float
@export var fov_max: float




### PHYSICS
# Movements PHYSICS
var speed: float = 0
var old_direction := Vector3.ZERO


### JUICE
# Movements JUICE
var head_time: float

# Field of view
var fov_base: float


func _ready() -> void:
	# Movements JUICE
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Field of view
	fov_base = camera.get_fov()


func _unhandled_input(event: InputEvent) -> void:
	# Head movements
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_strength
	
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_pressed("run"):
		max_speed = sprint_speed
	else:
		max_speed = walk_speed
	
	if is_on_floor():
		if direction:
			speed = min(speed + accel * delta, max_speed)
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
			
			old_direction = direction
			
		else:
			speed = max(0, speed - decel * delta)
			velocity.x = lerp(velocity.x, old_direction.x * speed, delta * ground_stop_coef)
			velocity.z = lerp(velocity.z, old_direction.z * speed, delta * ground_stop_coef)
		#print("\n speed: %.2f  |  accel : %.2f  |  decel : %.2f" % [speed, accel, decel])
	else:
		velocity.x = lerp(velocity.x, old_direction.x * speed, delta * air_stop_coef)
		velocity.z = lerp(velocity.z, old_direction.z * speed, delta * air_stop_coef)
	
	move_and_slide()

 
func _process(delta: float) -> void:
	# Head
	head_time = fmod(head_time + delta * velocity.length() * float(is_on_floor()), 5 * PI)
	camera.transform.origin = head_juice(head_time)
	
	# Field of view
	var fov_velocity_clamped = clampf(velocity.length(), fov_min, fov_max)
	var fov_target = fov_base + fov_change_coef * fov_velocity_clamped
	camera.fov = lerpf(camera.fov, fov_target, delta * fov_change_speed)


### PHYSICS functions


### JUICE functions


func head_juice(time: float) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * head_frequency) * head_amplitude
	pos.x = cos(time * head_frequency/2) * head_amplitude
	print("x: %.2f  |  y: %.2f" % [pos.x, pos.y])
	
	
	return pos
