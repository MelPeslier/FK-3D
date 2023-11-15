extends PlayerState


@export var air_state: PlayerState
@export var walk_state: PlayerState


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


func process_unhandled_input(_event: InputEvent) -> FiniteState:
	return null


func process_frame(_delta: float) -> FiniteState:
	return null
