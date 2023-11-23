extends Area3D

@onready var flower_detector_mesh: MeshInstance3D = $FlowerDetectorMesh
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

func _ready() -> void:
	flower_detector_mesh.mesh.radius = collision_shape_3d.shape.radius
	flower_detector_mesh.mesh.height = collision_shape_3d.shape.radius * 2


func modulate_zone(is_ok: bool) -> void:
	if is_ok:
		_modulate_zone(Color.ROYAL_BLUE)
	else:
		_modulate_zone(Color.FIREBRICK)

func _modulate_zone(_color: Color) -> void:
	var mat = flower_detector_mesh.material_override as ShaderMaterial
	mat.set_shader_parameter("color", _color)
