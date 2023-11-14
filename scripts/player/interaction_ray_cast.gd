extends RayCast3D

@export var player: Player

var last_collider: Object


func _physics_process(_delta: float) -> void:
	var collider = get_collider()
	
	if collider == null:
		if not last_collider == null:
			last_collider.hide_ui()
		
		return
	
	if collider.has_method("show_ui"):
		collider.show_ui(player)
	else :
		print("THA FUCK U DONT HAVE THIS ???   interaction_ray_cast of player")
	
	last_collider = collider
