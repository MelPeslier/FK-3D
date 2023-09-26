class_name Player
extends CharacterBody3D


@export_group("PHYSICS")
@export_subgroup("Movements")
@export var gravity: float
@export var jump_strength: float
@export var run_speed: float
@export var walk_speed: float
@export var accel: float
@export var ground_decel: float
@export var air_decel: float

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
var direction := Vector3.ZERO


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
	var next_direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	if is_on_floor():
		# Speed
		if Input.is_action_pressed("run"):
			speed = run_speed
		else:
			speed = walk_speed
		
		# Direction
		if next_direction:
			direction = _update_direction(delta, next_direction, accel)
			
		else:
			direction = _update_direction(delta, Vector3.ZERO, ground_decel)
		
	else:
		direction = _update_direction(delta, Vector3.ZERO, air_decel)
	
	_update_velocity()
	
	move_and_slide()

 
func _process(delta: float) -> void:
	# Head
	head_time = fmod(head_time + delta * velocity.length() * float(is_on_floor()), 5 * PI)
	camera.transform.origin = _head_juice(head_time)
	
	# Field of view
	var fov_velocity_clamped = clampf(velocity.length(), fov_min, fov_max)
	var fov_target = fov_base + fov_change_coef * fov_velocity_clamped
	camera.fov = lerpf(camera.fov, fov_target, delta * fov_change_speed)
	
	# Body / Hands



#****************************
# PHYSICS functions
#****************************
func _update_direction(delta: float, target_direction: Vector3, coef: float) -> Vector3:
	var new_direction = direction.lerp(target_direction, delta * coef)
	return new_direction


func _update_velocity() -> void:
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed



#****************************
# JUICE functions
#****************************


func _head_juice(time: float) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * head_frequency) * head_amplitude
	pos.x = cos(time * head_frequency/2) * head_amplitude
	return pos
