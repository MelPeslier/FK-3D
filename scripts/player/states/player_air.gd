extends PlayerState
@export_category("States")
@export var idle_state: PlayerState

@export_category("Variables")



func enter() -> void:
	pass


func exit() -> void:
	pass


func process_physics(delta: float) -> FiniteState:
	parent.velocity.y -= parent.gravity * delta

	parent.direction = parent._update_direction(delta, Vector3.ZERO, parent.air_decel)

	if parent.is_on_floor():
		return idle_state
	return null


func process_unhandled_input(_event: InputEvent) -> FiniteState:
	return null


func process_frame(_delta: float) -> FiniteState:
	return null
