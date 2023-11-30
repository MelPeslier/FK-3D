extends FlowerPhaseFiniteState


func enter() -> void:
	pass


func exit() -> void:
	pass


func process_physics(_delta: float) -> FiniteState:
	return null


func process_frame(_delta: float) -> FiniteState:
	return null


func on_day_start() -> FiniteState:
	return null


func on_placement_start() -> FiniteState:
	return null


func on_customer_start() -> FiniteState:
	return null


func on_night_start() -> FiniteState:
	return null

