extends WateringCanFiniteState

@export var idle_state: WateringCanFiniteState
@export var hold_state: WateringCanFiniteState


func enter() -> void:
	pass
#	print("enter fall")


func exit() -> void:
	pass
#	print("exit fall")


func process_physics(delta: float) -> FiniteState:
	parent.velocity.y -= parent.gravity * delta
	
	if parent.is_on_floor():
		return idle_state
	return null


func on_interactable_focused(_interactor: InteractorComponent) -> FiniteState:
	parent.modulate_item(Color.MEDIUM_AQUAMARINE)
	return null


func on_interactable_interacted(_interactor: InteractorComponent) -> FiniteState:
	parent.holder = _interactor.controller
	_interactor.item_received.emit(parent)
	return hold_state


func on_interactable_unfocused(_interactor: InteractorComponent) -> FiniteState:
	parent.modulate_item(Color.WHITE)
	return null
