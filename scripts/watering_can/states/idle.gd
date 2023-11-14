extends WateringCanFiniteState

@export var fall_state: WateringCanFiniteState
@export var hold_state: WateringCanFiniteState


func enter() -> void:
	parent.enable_collision_layers()
	print("enter idle")


func exit() -> void:
	parent.disable_collision_layers()
	print("exit idle")


func process_physics(_delta: float) -> FiniteState:
	if not parent.is_on_floor():
		return fall_state
	return null


func on_interactable_focused(_interactor: Interactor) -> FiniteState:
	print("focused")
	return null


func on_interactable_interacted(_interactor: Interactor) -> FiniteState:
	print("interacted")
	return hold_state


func on_interactable_unfocused(_interactor: Interactor) -> FiniteState:
	print("unfocused")
	return null
