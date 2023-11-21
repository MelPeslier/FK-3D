class_name Sunflower
extends WaterFlower


func _ready() -> void:
	super()
	flower_data.nearby_happ_decr_coef_changed.connect(_on_nearby_happ_decr_coef_changed)

func _process(delta: float) -> void:
	water_component.process_frame(delta)
	
	


func _on_nearby_happ_decr_coef_changed(old_value: float, new_value: float) -> void:
	for flower in nearby_water_flowers:
		flower.happiness_component.alter_decrease_coef(old_value, new_value)




