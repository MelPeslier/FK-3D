class_name Interactor
extends Area3D


var controller: Node3D


func interact(interactable: Interactable) -> void:
	print("interactor : emit : interact")
	interactable.interacted.emit(self)


func focus(interactable: Interactable) -> void:
	print("interactor : emit : focus")
	interactable.focused.emit(self)


func unfocus(interactable: Interactable) -> void:
	print("interactor : emit : unfocus")
	interactable.unfocused.emit(self)


func get_closest_interactable() -> Interactable:
	var list: Array[Area3D] = get_overlapping_areas()
	var distance: float
	var closest_distance: float = INF
	var closest: Interactable = null
	
	for interactable in list:
		distance = interactable.global_position.distance_to(global_position)
		
		if distance < closest_distance:
			closest = interactable as Interactable
			closest_distance = distance
	
	return closest
