class_name WateringCanInteractorComponent
extends InteractorComponent

@export var watering_can: WateringCan

var cached_closest: InteractableComponent


func _ready() -> void:
	area_exited.connect(_on_area_exited)
	controller = watering_can


func process_physics(_delta: float) -> void:
	var new_closest: InteractableComponent = get_closest_interactable()
	if new_closest != cached_closest:
		if is_instance_valid(cached_closest):
			unfocus(cached_closest)
			item_unfocus.emit()
		if new_closest:
			focus(new_closest)
	cached_closest = new_closest


func _on_area_exited(_area: InteractableComponent) -> void:
	pass
#	if cached_closest == area:
#		print("area exited unfocus")
#		unfocus(area)
