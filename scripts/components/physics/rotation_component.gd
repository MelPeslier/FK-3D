class_name RotationComponent
extends Node

enum Mode {
	DIRECT,
	CONSTANT,
	SMOOTH
}

@export var mode: Mode
@export var speed: float = 1


func rotate_around(delta: float, pivot: Node3D, target: Node3D) -> void:
	# magintude
	var direction := Vector2( target.position.x, target.position.z ) - Vector2( pivot.position.x, pivot.position.z )
	var rotation: float = 0
	
	match mode:
		Mode.DIRECT:
			pivot.rotation.y = atan2(-direction.x, -direction.y)
		
		Mode.CONSTANT:
			var front: Vector2 = Vector2( pivot.transform.basis.z.x, pivot.transform.basis.z.z )
			var angle := front.angle_to(direction)
			var angle_delta = deg_to_rad(speed) * delta
			print(rad_to_deg(angle))
			angle = lerp_angle( pivot.rotation.y, atan2(-direction.x, -direction.y), 1.0)
			angle = clamp( angle, pivot.rotation.y - angle_delta, pivot.rotation.y + angle_delta)
			pivot.rotation.y = angle
		
		Mode.SMOOTH:
			pivot.rotation.y = lerp_angle(pivot.rotation.y, atan2(-direction.x, -direction.y), delta * deg_to_rad(speed) )
		
