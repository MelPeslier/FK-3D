extends Node3D

@export var parent: Flower

func _ready() -> void:
	RenderingServer.frame_post_draw.connect(_on_frame_post_draw)

func _on_frame_post_draw() -> void:
	var sv := $SubViewport
	var dm := $DisplayMesh
	
	var viewport_texture = sv.get_texture()
	var mat = StandardMaterial3D.new()
	mat.resource_local_to_scene = true
	mat.albedo_texture = viewport_texture
	
	dm.set_surface_override_material(0, mat)
	
#	# Update size
#	var s_x: float = sv.size.x * 1.0 / sv.size.y
#	if s_x >= 1:
#		dm.mesh.size.x *= s_x
#		return
#
#	var s_y: float = sv.size.y * 1.0 / sv.size.x
#	dm.mesh.size.y *= s_y
