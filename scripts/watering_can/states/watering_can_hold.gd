extends WateringCanFiniteState

@export_category("States")
@export var idle_state: WateringCanFiniteState

@export_category("Nodes")
@export var interactor_component: WateringCanInteractorComponent


func enter() -> void:
	print("enter hold")


func exit() -> void:
	print("exit hold")


func process_physics(delta: float) -> FiniteState:
	interactor_component.process_physics(delta)
	
	if Input.is_action_pressed("interact"):
		parent.watering(delta)
	
	return null


# From holder
func process_unhandled_input(event: InputEvent) -> FiniteState:
	if event.is_action_pressed("disjoin"):
		parent.holder.drop_item.emit()
		parent.holder = null
		return idle_state
	
	return null
