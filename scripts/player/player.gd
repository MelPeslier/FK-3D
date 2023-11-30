class_name Player
extends CharacterBody3D

signal drop_item

@export_group("PHYSICS")
@export_subgroup("Movements")
@export var accel: float
@export var ground_decel: float
@export var air_decel: float

@export_group("JUICE")
@export_subgroup("Head movements")
@export var camera: Camera3D
@export var sensitivity: float
@export var rotation_speed_max: float
@export var head: Head
@export var head_frequency: float
@export var head_amplitude: float

@export_subgroup("Field of view")
@export var fov_change_coef: float
@export var fov_change_speed: float
@export var fov_min: float
@export var fov_max: float

@export_subgroup("Body movements")
@export var body: Body
@export var body_rotation_speed: float
@export var body_angle_limit: float

@export_subgroup("Hands")
@export var left_marker: Marker3D
@export var left_hand: Hand
@export var right_marker: Marker3D
@export var right_hand: Hand

@export_group("State Machine")
@export var state_machine: FiniteStateMachine

@export_group("Item")
@export var player_interactor_component: PlayerInteractorComponent

@export var rotation_component: RotationComponent

### PHYSICS
# Movements PHYSICS
var speed: float = 0
var direction := Vector3.ZERO
var next_direction := Vector3.ZERO
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


### JUICE
# Movements JUICE
var head_time: float

# Field of view
var fov_base: float

# Body rotation
var swap := false

### Object to hold
var item: Node3D


func _ready() -> void:
	# Movements JUICE
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Field of view
	fov_base = camera.get_fov()
	body_rotation_speed = deg_to_rad(body_rotation_speed)
	body_angle_limit = deg_to_rad(body_angle_limit)
	
	state_machine.init(self)


func _unhandled_input(event: InputEvent) -> void:
	# Head movements
	if event is InputEventMouseMotion:
		var rotation_speed_y = clampf(-event.relative.x * sensitivity, -rotation_speed_max, rotation_speed_max)
		head.rotate_y(rotation_speed_y)
		
		var rotation_speed_x = clampf(-event.relative.y * sensitivity, -rotation_speed_max/2.0, rotation_speed_max/2.0)
		camera.rotate_x(rotation_speed_x)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
	
	state_machine.process_unhandled_input(event)
	process_unhandled_input(event)


func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	next_direction = (head.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	state_machine.process_physics(delta)
	
	_update_velocity()
	move_and_slide()
	
	hold_item(delta)

 
func _process(delta: float) -> void:
	# Head
	head_time = fmod(head_time + delta * velocity.length() * float(is_on_floor()), 5 * PI)
	camera.transform.origin = _update_camera_position(head_time)
	
	# Field of view
	var fov_velocity_clamped = clampf(velocity.length(), fov_min, fov_max)
	var fov_target = fov_base + fov_change_coef * fov_velocity_clamped
	camera.fov = lerpf(camera.fov, fov_target, delta * fov_change_speed)
	
	# Body
	body.rotation.y = _follow_camera_rotation(delta, body.rotation.y, head.rotation.y, body_angle_limit, body_rotation_speed)
	
	# Hands
	
	state_machine.process_frame(delta)



#****************************
# PHYSICS
#****************************
func _update_direction(delta: float, target_direction: Vector3, coef: float) -> Vector3:
	var new_direction = direction.lerp(target_direction, delta * coef)
	return new_direction


func _update_velocity() -> void:
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed



#****************************
# JUICE
#****************************
func _update_camera_position(time: float) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * head_frequency) * head_amplitude
	pos.x = cos(time * head_frequency/2) * head_amplitude
	return pos


# B : Body 'y' rotaion
# H : Head 'y' rotation 
# L : Limit 'y' rotation difference between the Body and the Head
func _follow_camera_rotation(delta: float, B: float, H: float, L: float, weight: float) -> float:
	var target: float
	if abs(H) > PI - L and sign(H) != sign(B):
		target = sign(B) * (TAU - abs(H))
		#print("Special ******")
		swap = true
	else:
		#print("Normal")
		target = H
		
		if swap :
			swap = false
			var diff = PI - abs(B)
			B = sign(H) * (PI + diff)
			#print("reverse Body : %.1f" % [rad_to_deg(B)])
	
	B = clampf(B, target - L, target + L)
	B = lerp_angle(B, target, delta * weight)
	#print("target : %.1f  |  Body : %.1f  |  Head : %.1f" % [rad_to_deg(target), rad_to_deg(B), rad_to_deg(H)])
	return B



func _on_player_interactor_component_item_received(obj) -> void:
	item = obj


func _on_drop_item() -> void:
	item.dropped.emit()
	player_interactor_component.reset_cached_closest()
	item = null


func process_unhandled_input(event: InputEvent):
	if item:
		item.process_unhandled_input(event)
		if event.is_action_pressed("disjoin"):
			drop_item.emit()
	
	else:
		player_interactor_component.process_unhandled_input(event)


func hold_item(delta: float) -> void:
	if not item:
		player_interactor_component.process_physics(delta)
	
	if not item: return
	
	var dir := right_hand.global_position - item.global_position
	
	item.velocity = dir * 10.0
	item.move_and_slide()
	
	item.global_transform.basis = right_marker.global_transform.basis
#	rotation_component.rotate_towards(delta, item, self)
	item.transform = item.transform.orthonormalized()
	
	if item is Flower:
		var i = item as Flower
		i.process_physics_player(delta)
