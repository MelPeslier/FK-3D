extends FiniteStateMachine


func _ready() -> void:
	Event.day_start.connect(on_day_start)
	Event.customer_start.connect(on_customer_start)
	Event.placement_start.connect(on_placement_start)
	Event.night_start.connect(on_night_start)


func on_day_start() -> void:
	var new_state = current_state.on_day_start()
	if new_state:
		change_state(new_state)


func on_placement_start() -> void:
	var new_state = current_state.on_placement_start()
	if new_state:
		change_state(new_state)


func on_customer_start() -> void:
	var new_state = current_state.on_customer_start()
	if new_state:
		change_state(new_state)


func on_night_start() -> void:
	var new_state = current_state.on_night_start()
	if new_state:
		change_state(new_state)
