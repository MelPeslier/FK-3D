extends PlayerState

@export_category("States")
@export var air_state: PlayerState

@export_category("Variables")
@export var jump_strength: float


func enter() -> void:
	parent.velocity.y = jump_strength


func exit() -> void:
	pass


func process_physics(_delta: float) -> FiniteState:
	if not parent.is_on_floor():
		return air_state

	return null


func process_unhandled_input(_event: InputEvent) -> FiniteState:
	return null


func process_frame(_delta: float) -> FiniteState:
	return null
