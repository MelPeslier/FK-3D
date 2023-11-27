extends PlayerState


@export_category("States")
@export var air_state: PlayerState
@export var walk_state: PlayerState
@export var jump_state: PlayerState


func enter() -> void:
	pass


func exit() -> void:
	pass


func process_physics(delta: float) -> FiniteState:
	parent.direction = parent._update_direction(delta, Vector3.ZERO, parent.ground_decel)
	
	if not parent.is_on_floor():
		return air_state
	
	if parent.next_direction:
		return walk_state
	
	return null


func process_unhandled_input(event: InputEvent) -> FiniteState:
	if event.is_action_pressed("jump") and parent.is_on_floor():
		return jump_state
	
	return null


func process_frame(_delta: float) -> FiniteState:
	return null
