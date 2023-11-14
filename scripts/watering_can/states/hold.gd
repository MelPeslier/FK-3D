extends WateringCanFiniteState


@export var idle_state: WateringCanFiniteState
@export var water_state: WateringCanFiniteState


func enter() -> void:
	print("enter hold")


func exit() -> void:
	print("exit hold")


func process_input(event: InputEvent) -> FiniteState:
	if event.is_action_pressed("interact"):
		return water_state
	if event.is_action_pressed("disjoin"):
		return idle_state
	return null
