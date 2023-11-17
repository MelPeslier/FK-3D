class_name WaterFlower
extends Flower


@export_group("Components")
@export var happiness_component: HappinessComponent
@export var interactable_component: InteractableComponent


func watering(delta: float, water_amount) -> void:
	water_component.add_water(delta, water_amount)


func _on_interactable_component_focused(_interactor: InteractorComponent) -> void:
	_interactor.item_received.emit(self)
	print("item_receveid")


func _on_interactable_component_interacted(_interactor: InteractorComponent) -> void:
	pass # Replace with function body.


func _on_interactable_component_unfocused(_interactor: InteractorComponent) -> void:
	print("unfocus")

