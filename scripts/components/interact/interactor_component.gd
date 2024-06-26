class_name InteractorComponent
extends Area3D

signal item_unfocus
signal item_received(obj: Node3D)

var controller: Node3D


func interact(interactable: InteractableComponent) -> void:
	interactable.interacted.emit(self)


func focus(interactable: InteractableComponent) -> void:
	interactable.focused.emit(self)


func unfocus(interactable: InteractableComponent) -> void:
	interactable.unfocused.emit(self)


func get_closest_interactable() -> InteractableComponent:
	var list: Array[Area3D] = get_overlapping_areas()
	var distance: float
	var closest_distance: float = INF
	var closest: InteractableComponent = null

	for interactable in list:
		distance = interactable.global_position.distance_to(global_position)

		if distance < closest_distance:
			closest = interactable as InteractableComponent
			closest_distance = distance

	return closest
