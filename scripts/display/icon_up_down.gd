extends PanelContainer

var coef: float:
	set(new_value):
		coef = remap(new_value, 0.5, 1.25, 0.0, 1.0)
		var mat = material as ShaderMaterial
		mat.set_shader_parameter("coef", coef)
