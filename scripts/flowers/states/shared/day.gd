extends FlowerPhaseFiniteState


@export var night: FiniteState


func enter() -> void:
	pass


func exit() -> void:
	pass


func process_physics(_delta: float) -> FiniteState:
	return null


func process_frame(_delta: float) -> FiniteState:
	return null


func on_night_start() -> FiniteState:
	return night

