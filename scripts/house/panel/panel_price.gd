class_name PanelPrice
extends MeshInstance3D


@export_range(0, 1) var end_alpha: float = 0.3
@export var label_price: Label3D

var _tween: Tween

var _mat_alpha: float:
	set(val):
		_mat_alpha = clamp(val, 0.0, 1.0)
		set_instance_shader_parameter("alpha", _mat_alpha)

var _mat_color: Color:
	set(val):
		_mat_color = val
		set_instance_shader_parameter("color", _mat_color)


func _ready() -> void:
	# Panel
	_mat_alpha = 0.0
	_mat_color = MyColor.normal
	visible = false

	# Label
	label_price.scale = Vector3.ZERO
	label_price.rotation.z = 0.0


func appear(_color: Color, _duration: float = 1) -> void:
	if _tween :
		_tween.kill()

	var _tween_time := remap(end_alpha, 0, end_alpha, 0, _duration)

	_tween = create_tween()
	_tween.tween_callback(set_visible.bind(true))

	# Color transition
	_tween.tween_property(self, "_mat_alpha", end_alpha, _tween_time)\
		.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	_tween.parallel().tween_property(self, "_mat_color", _color, _tween_time * 0.35)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# Label transition
	var _final_scale := Vector3.ONE
	_tween.parallel().tween_property(label_price, "scale", _final_scale, _tween_time)\
		.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	_tween.parallel().tween_property(label_price, "rotation:z", -TAU, _tween_time)\
		.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)



func disappear(_color: Color = MyColor.normal, _duration: float = 1) -> void:
	if _tween :
		_tween.kill()

	var _tween_time := remap(_mat_alpha, 0, end_alpha, 0, _duration)

	_tween = create_tween()

	# Color transition
	_tween.tween_property(self, "_mat_alpha", 0.0, _tween_time)\
		.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)

	# Label transition
	var _final_scale := Vector3.ZERO
	_tween.parallel().tween_property(label_price, "scale", _final_scale, _tween_time)\
		.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN)
	_tween.parallel().tween_property(label_price, "rotation:z", 0.0, _tween_time)\
		.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN)

	_tween.tween_property(self, "_mat_color", _color, 0.001)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_tween.tween_callback(set_visible.bind(false))

