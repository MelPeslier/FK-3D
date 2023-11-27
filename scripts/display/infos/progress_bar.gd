extends PanelContainer

var edge: float:
	set(new_value):
		new_value = remap(new_value, 0, 100, 0, 1)
		edge = clamp(new_value, 0.0, 1.0)
		var mat = material as ShaderMaterial
		mat.set_shader_parameter("value", edge)


var color: Color:
	set(new_value):
		color = new_value
		var mat = material as ShaderMaterial
		mat.set_shader_parameter("front_color", color) 


var thresh_1: float:
	set(new_value):
		new_value = remap(new_value, 0, 100, 0, 1)
		thresh_1 = clamp(new_value, 0.0, 1.0)
		var mat = material as ShaderMaterial
		mat.set_shader_parameter("thresh_1", thresh_1)


var thresh_2: float:
	set(new_value):
		new_value = remap(new_value, 0, 100, 0, 1)
		thresh_2 = clamp(new_value, 0.0, 1.0)
		var mat = material as ShaderMaterial
		mat.set_shader_parameter("thresh_2", thresh_2)


var thresh_3: float:
	set(new_value):
		new_value = remap(new_value, 0, 100, 0, 1)
		thresh_3 = clamp(new_value, 0.0, 1.0)
		var mat = material as ShaderMaterial
		mat.set_shader_parameter("thresh_3", thresh_3)
