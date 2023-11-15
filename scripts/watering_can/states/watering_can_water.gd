extends WateringCanFiniteState

@export var hold_state: WateringCanFiniteState

func enter() -> void:
	print("enter water")


func exit() -> void:
	print("exit water")



func process_unhandled_input(event: InputEvent) -> FiniteState:
	if event.is_action_released("interact"):
		return hold_state
	return null



