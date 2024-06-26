extends WateringCanFiniteState

@export_category("States")
@export var idle_state: WateringCanFiniteState

@export_category("Nodes")
@export var interactor_component: WateringCanInteractorComponent


func enter() -> void:
	parent.modulate_item(Color.WHITE)
#	print("enter hold")


func exit() -> void:
	pass
#	print("exit hold")


func process_physics(delta: float) -> FiniteState:
	interactor_component.process_physics(delta)

	if Input.is_action_pressed("interact"):
		if parent.flower == null:
			if interactor_component.cached_closest != null:
				interactor_component.interact(interactor_component.cached_closest)
		else:
			parent.watering(delta)

	return null


# From holder
func on_dropped() -> FiniteState:
	parent.holder = null
	if interactor_component.cached_closest:
		interactor_component.unfocus(interactor_component.cached_closest)
		interactor_component.cached_closest = null
	return idle_state
