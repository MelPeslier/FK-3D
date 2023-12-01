class_name FiniteStateMachine
extends Node

@export var starting_state: FiniteState
var current_state: FiniteState


func init(parent: Node) -> void:
	for child in get_children():
		child.parent = parent

	change_state(starting_state)


func change_state(new_state: FiniteState) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()


func process_physics(delta: float) -> void:
	var new_state := current_state.process_physics(delta)
	if new_state:
		change_state(new_state)


func process_unhandled_input(event: InputEvent) -> void:
	var new_state := current_state.process_unhandled_input(event)
	if new_state:
		change_state(new_state)


func process_frame(delta: float) -> void:
	var new_state := current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

