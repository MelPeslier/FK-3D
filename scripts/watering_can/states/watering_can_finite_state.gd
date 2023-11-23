class_name WateringCanFiniteState
extends FiniteState


var parent: WateringCan


func on_interactable_focused(_interactor: InteractorComponent) -> FiniteState:
	return null


func on_interactable_interacted(_interactor: InteractorComponent) -> FiniteState:
	return null


func on_interactable_unfocused(_interactor: InteractorComponent) -> FiniteState:
	return null


func on_dropped() -> FiniteState:
	return null
