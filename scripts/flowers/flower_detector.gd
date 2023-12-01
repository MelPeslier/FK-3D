extends Area3D

@export var appear_time: float
@export var good_color: Color = Color.ROYAL_BLUE

@export var disappear_time: float
@export var bad_color: Color = Color.FIREBRICK

@onready var flower_detector_mesh: MeshInstance3D = $FlowerDetectorMesh
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

var max_size: float
var tween: Tween

func _ready() -> void:
	max_size = collision_shape_3d.shape.radius
	flower_detector_mesh.mesh.radius = collision_shape_3d.shape.radius
	flower_detector_mesh.mesh.height = collision_shape_3d.shape.radius * 2


func _modulate_zone_color(_color: Color) -> void:
	flower_detector_mesh.set_instance_shader_parameter("color", _color)


func _modulate_zone_alpha(_alpha: float) -> void:
	flower_detector_mesh.set_instance_shader_parameter("alpha", _alpha)


func appear_zone(appear: bool) -> void:
	var actual_color: Color = flower_detector_mesh.get_instance_shader_parameter("color")
	var actual_alpha: float = flower_detector_mesh.get_instance_shader_parameter("alpha")

	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()

	if appear:
		tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_method(_modulate_zone_color, actual_color, bad_color, appear_time * 1.25)
		tween.parallel().tween_method(_modulate_zone_alpha, actual_alpha, 1.0, appear_time * 1.25)

		tween.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(flower_detector_mesh, "mesh:radius", max_size, appear_time)
		tween.parallel().tween_property(flower_detector_mesh, "mesh:height", max_size * 2.0, appear_time)

	else:
		tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_method(_modulate_zone_color, actual_color, good_color, disappear_time * 0.4)
		tween.parallel().tween_method(_modulate_zone_alpha, actual_alpha, 0.0, disappear_time * 0.9)

		tween.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN)
		tween.parallel().tween_property(flower_detector_mesh, "mesh:radius", 0.0, disappear_time)
		tween.parallel().tween_property(flower_detector_mesh, "mesh:height", 0.0, disappear_time)

