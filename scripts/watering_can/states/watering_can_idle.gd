extends WateringCanFiniteState

@export var fall_state: WateringCanFiniteState
@export var hold_state: WateringCanFiniteState


func enter() -> void:
#	print("enter idle")
	pass


func exit() -> void:
#	print("exit idle")
	pass


func process_physics(delta: float) -> FiniteState:
	if not parent.is_on_floor():
		return fall_state

	parent.velocity = parent._update_direction(delta, parent.velocity, Vector3.ZERO, 4.5)

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
