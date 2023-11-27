extends PlayerState

@export_category("States")
@export var idle_state: PlayerState
@export var run_state: PlayerState
@export var air_state: PlayerState
@export var jump_state: PlayerState

@export_category("Components")
@export var player_interactor_component: PlayerInteractorComponent

@export_category("Variables")
@export var walk_speed: float


func enter() -> void:
	parent.speed = walk_speed


func exit() -> void:
	pass


func process_physics(delta: float) -> FiniteState:
	if parent.next_direction:
		parent.direction = parent._update_direction(delta, parent.next_direction, parent.accel)
	else:
		return idle_state

	if Input.is_action_pressed("run"):
		return run_state

	if not parent.is_on_floor():
		return air_state
	
	return null


func process_unhandled_input(event: InputEvent) -> FiniteState:
	if event.is_action_pressed("jump") and parent.is_on_floor():
		return jump_state
	
	return null


func process_frame(_delta: float) -> FiniteState:
	return null

