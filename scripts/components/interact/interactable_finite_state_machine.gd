extends FiniteStateMachine


func on_interactable_focused(interactor: Interactor) -> void:
	var new_state = current_state.on_interactable_focused(interactor)
	if new_state:
		change_state(new_state)


func on_interactable_interacted(interactor: Interactor) -> void:
	var new_state = current_state.on_interactable_interacted(interactor)
	if new_state:
		change_state(new_state)


func on_interactable_unfocused(interactor: Interactor) -> void:
	var new_state = current_state.on_interactable_unfocused(interactor)
	if new_state:
		change_state(new_state)
