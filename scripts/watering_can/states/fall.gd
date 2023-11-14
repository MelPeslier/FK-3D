extends WateringCanFiniteState

@export var idle_state: WateringCanFiniteState
@export var hold_state: WateringCanFiniteState


func enter() -> void:
	parent.enable_collision_layers()
	print("enter fall")


func exit() -> void:
	parent.disable_collision_layers()
	print("exit fall")


func process_physics(delta: float) -> FiniteState:
	parent.velocity.y -= parent.gravity * delta
	parent.move_and_slide()
	
	if parent.is_on_floor():
		return idle_state
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
