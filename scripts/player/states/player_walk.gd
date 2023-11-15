extends PlayerState


@export var idle_state: PlayerState
@export var run_state: PlayerState
@export var air_state: PlayerState


func enter() -> void:
	parent.speed = parent.walk_speed


func exit() -> void:
	pass


func process_physics(delta: float) -> FiniteState:
	
	if parent.next_direction:
		parent.direction = parent._update_direction(delta, parent.next_direction, parent.accel)
	else:
		return idle_state

	if not parent.is_on_floor():
		return air_state
	return null


func process_unhandled_input(event: InputEvent) -> FiniteState:
	if event.is_action_pressed("run"):
		return run_state
		
	if event.is_action_pressed("jump") and parent.is_on_floor():
		parent.velocity.y = parent.jump_strength
		return air_state
	return null


func process_frame(_delta: float) -> FiniteState:
	return null

