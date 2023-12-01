extends PlayerState

@export_category("States")
@export var idle_state: PlayerState
@export var walk_state: PlayerState
@export var air_state: PlayerState
@export var jump_state: PlayerState

@export_category("Variables")
@export var run_speed: float



func enter() -> void:
	parent.speed = run_speed


func exit() -> void:
	pass


func process_physics(delta: float) -> FiniteState:
	if not parent.next_direction:
		return idle_state

	parent.direction = parent._update_direction(delta, parent.next_direction, parent.accel)

	if not Input.is_action_pressed("run"):
		return walk_state

	if not parent.is_on_floor():
		return air_state

	return null


func process_unhandled_input(event: InputEvent) -> FiniteState:
	if event.is_action_pressed("jump") and parent.is_on_floor():
		return jump_state
	return null


func process_frame(_delta: float) -> FiniteState:
	return null
