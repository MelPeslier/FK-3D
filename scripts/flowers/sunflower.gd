class_name Sunflower
extends WaterFlower


func _ready() -> void:
	super()
	flower_data.nearby_happ_decr_coef_changed.connect(_on_nearby_happ_decr_coef_changed)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity
	else:
		velocity = _update_direction(delta, velocity, Vector3.ZERO, 4.5)
	
	move_and_slide()


func _process(delta: float) -> void:
	water_component.process_frame(delta)
	
	var new_happ_decr: float = remap(
		happiness_component.happiness,
		happiness_component.MIN,
		happiness_component.max_max,
		flower_data.min_nearby_happ_decr_coef,
		flower_data.max_nearby_happ_decr_coef
	)
	
	flower_data.nearby_happ_decr_coef = new_happ_decr
	
	if happiness_component.is_happ_max():
		for flower in nearby_water_flowers:
			flower.happiness_component.add_happ(delta, flower_data.nearby_happ_val)


func _on_nearby_happ_decr_coef_changed(old_value: float, new_value: float) -> void:
	for flower in nearby_water_flowers:
		flower.happiness_component.alter_decrease_coef(old_value, new_value)


func _update_direction(delta: float, direction: Vector3, target_direction: Vector3, coef: float) -> Vector3:
	var new_direction = direction.lerp(target_direction, delta * coef)
	return new_direction

