extends Node3D

# Types of conversion from 2d control to 3d mesh ui
enum Conversion {
	SIZE,
	SCALE
}

@export var parent: Flower
@export var display_content_path: String
@export var conversion: Conversion
@export var pixel_per_meter: float = 200


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
			display_mesh.mesh.size = sub_viewport.size / pixel_per_meter
			print(pixel_per_meter)
		
		Conversion.SCALE:
			var _scale: float = sub_viewport.size.x * 1.0 / sub_viewport.size.y
			if _scale >= 1:
				display_mesh.scale.x = _scale
			else:
				_scale = sub_viewport.size.y * 1.0 / sub_viewport.size.x
				display_mesh.scale.y = _scale
	
	RenderingServer.frame_post_draw.disconnect(_on_frame_post_draw)
