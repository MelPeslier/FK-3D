extends FiniteStateMachine

# Interactions
func _on_interactable_focused(interactor: InteractorComponent) -> void:
	var new_state = current_state.on_interactable_focused(interactor)
	if new_state:
		change_state(new_state)


func _on_interactable_interacted(interactor: InteractorComponent) -> void:
	var new_state = current_state.on_interactable_interacted(interactor)
	if new_state:
		change_state(new_state)


func _on_interactable_unfocused(interactor: InteractorComponent) -> void:
	var new_state = current_state.on_interactable_unfocused(interactor)
	if new_state:
		change_state(new_state)
