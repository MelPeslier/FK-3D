extends WateringCanFiniteState

@export var fall_state: WateringCanFiniteState
@export var hold_state: WateringCanFiniteState


func enter() -> void:
	print("enter idle")
	parent.enable_collision_layers()


func exit() -> void:
	print("exit idle")
	parent.disable_collision_layers()


func process_physics(_delta: float) -> FiniteState:
	if not parent.is_on_floor():
		return fall_state
	
	return null


func on_interactable_focused(_interactor: InteractorComponent) -> FiniteState:
	return null


func on_interactable_interacted(_interactor: InteractorComponent) -> FiniteState:
	parent.holder = _interactor.controller
	_interactor.item_received.emit(parent)
	return hold_state


func on_interactable_unfocused(_interactor: InteractorComponent) -> FiniteState:
	return null
