extends PlayerState

func enter() -> void:
	pass


func exit() -> void:
	pass


func process_physics(_delta: float) -> FiniteState:
	return null


func process_unhandled_input(_event: InputEvent) -> FiniteState:
	return null


func process_frame(_delta: float) -> FiniteState:
	return null
