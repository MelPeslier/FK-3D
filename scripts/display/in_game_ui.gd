extends Node3D

# Types of conversion from 2d control to 3d mesh ui
enum Conversion {
	SIZE,
	SCALE
}

# Predefined anchors for UI mesh placement
enum Anchor {
	NEGATIVE = -1,
	CENTER = 0,
	POSITIVE = 1
}

@export var parent: Flower
@export var display_content_path: String 
@export var conversion: Conversion
@export var pixel_per_meter := 200
@export var body: MeshInstance3D
@export_range(0.5, 1, 0.05) var coef_distance := 0.5
@export_range(-0.15, 1.15, 0.05) var coef_height: float

@export var anchor_x: Anchor
@export var anchor_y: Anchor
@export var anchor_z: Anchor



func _ready() -> void:
	RenderingServer.frame_post_draw.connect(_on_frame_post_draw)

# Need to set the mesh resource to local
func _on_frame_post_draw() -> void:
	if display_content_path.is_empty(): 
		RenderingServer.frame_post_draw.disconnect(_on_frame_post_draw)
		return
	
	var sub_viewport := $SubViewport
	var display_mesh := $DisplayMesh
	
	# Make SubViewport size proportional to the Control node in it
	var display_content_scene = load(display_content_path).instantiate()
	sub_viewport.size = display_content_scene.size
	sub_viewport.add_child(display_content_scene)
	
	# Get the viewport texture and asign it to a mateial
	var viewport_texture = sub_viewport.get_texture()
	var mat = StandardMaterial3D.new()
	mat.resource_local_to_scene = true
	mat.albedo_texture = viewport_texture
	
	# Then asign this material to the surface texture
	display_mesh.set_surface_override_material(0, mat)
	
	# Update the scale of the rendering mesh
	match conversion:
		Conversion.SIZE:
			print(sub_viewport.size.y)
			display_mesh.mesh.size = sub_viewport.size / float(pixel_per_meter)
#			print("\n\n" + str (parent.name))
#			print("%f / %f = %f and needs to be : %f" % [sub_viewport.size.y, pixel_per_meter, display_mesh.mesh.size.y, sub_viewport.size.y / float(pixel_per_meter)])
			Vector2(2, 6.165)
		
		Conversion.SCALE:
			var _scale: float = sub_viewport.size.x * 1.0 / sub_viewport.size.y
			if _scale >= 1:
				display_mesh.scale.x = _scale
			else:
				_scale = sub_viewport.size.y * 1.0 / sub_viewport.size.x
				display_mesh.scale.y = _scale
	
	# Update the display screen position depending on the body mesh size and scale
	if body != null:
		position = _update_position(body.mesh.radius * 2, body.mesh.height, body.mesh.radius * 2, body.scale)
	
	RenderingServer.frame_post_draw.disconnect(_on_frame_post_draw)


func _update_position(width: float, height: float, depth: float, _scale: Vector3) -> Vector3:
	var display_mesh = $DisplayMesh
	
	var display_mesh_y: float = display_mesh.mesh.size.y * display_mesh.scale.y
	var height_y := height * _scale.y
	
	# Choose yourself the position of the label with the coef
	# For < 0 and for > 1, the coef is a margin
	var target_y: float
	if coef_height < 0:
		target_y = - (display_mesh_y / 2.0 ) + coef_height
	elif coef_height > 1:
		target_y = (height_y + display_mesh_y / 2.0) + coef_height - 1
	else:
		target_y = height_y * coef_height
	
	if display_mesh_y > height_y:
		print("oui")
		target_y = display_mesh_y - height_y
		
	
	print("body mesh : %.f  |  display mesh : %.f" % [height, display_mesh.mesh.size.y])
	print("height: %f  | mesh_size: %f" % [height_y,  display_mesh_y])
	
	var big_xz := depth
	var big_scale := _scale.z
	if width > depth:
		big_xz = width
		big_scale = _scale.x
	
	var target_x: float = (big_xz * big_scale + display_mesh.mesh.size.x * display_mesh.scale.x) * coef_distance
	
	var target_position := Vector3(-1 * target_x, target_y, 0)
	
	return target_position





