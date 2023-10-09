extends Node

enum Mode {
	DIRECT,
	CONSTANT,
	SMOOTH
}

@export var mode: Mode
@export var speed: float = 1

var direction := Vector3.FORWARD

func rotate_around(pivot: Object, target: Object, axis:) -> void:
	match mode:
		Mode.DIRECT:
			pivot.rotation.y = atan2(-direction.x, -direction.z)
		
		Mode.CONSTANT:
			var front = pivot.transform.basis.z
			var ang = Vector2(front.x, front.z).angle_to(Vector2(direction.x, direction.z))
			
		
#		Mode.SMOOTH:
		
