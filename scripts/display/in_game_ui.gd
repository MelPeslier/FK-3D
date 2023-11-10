class_name InGameUi
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
@export var sub_viewport: SubViewport
@export var display_content: Control 
@export var conversion: Conversion
@export var pixel_per_meter := 200
@export var body: MeshInstance3D
@export var margin := Vector3(0.1, 0.1, 0.1)
@export var anchor_x: Anchor
@export var anchor_y: Anchor
@export var anchor_z: Anchor

@export var rotation_component: RotationComponent

var player: Player

@onready var display_mesh: MeshInstance3D = $DisplayMesh

func _ready() -> void:
	RenderingServer.frame_post_draw.connect(_on_frame_post_draw)
	
	visible = false
	set_process(false)


func _process(delta: float) -> void:
	if player == null: return
	
	rotation_component.rotate_towards(delta, player)


# Need to set the mesh resource to local
func _on_frame_post_draw() -> void:
	if display_content == null: return
	
#	# Make SubViewport size proportional to the Control node in it
	sub_viewport.size = display_content.size
	
	# Get the viewport texture and asign it to a mateial
	var viewport_texture = sub_viewport.get_texture()
	var mat = display_mesh.material_override
	mat.albedo_texture = viewport_texture
	
	# Update the scale of the rendering mesh
	match conversion:
		Conversion.SIZE:
			display_mesh.mesh.size = sub_viewport.size / float(pixel_per_meter)
			
#			print("\n\n" + str (parent.name))
#			print("%f / %f = %f and needs to be : %f" % [sub_viewport.size.y, pixel_per_meter, display_mesh.mesh.size.y, sub_viewport.size.y / float(pixel_per_meter)])
		
		Conversion.SCALE:
			var _scale: float = sub_viewport.size.x * 1.0 / sub_viewport.size.y
			if _scale >= 1:
				display_mesh.scale.x = _scale
			else:
				_scale = sub_viewport.size.y * 1.0 / sub_viewport.size.x
				display_mesh.scale.y = _scale
	
	# Update the display screen position depending on the body mesh size and scale
	if body != null:
		display_mesh.position = _update_position(body.mesh.radius * 2, body.mesh.height, body.mesh.radius * 2, body.scale)
	
	RenderingServer.frame_post_draw.disconnect(_on_frame_post_draw)


func _update_position(_x: float, _y: float, _z: float, _scale: Vector3) -> Vector3:
	var target_position := Vector3.ZERO
	
	var _body := Vector3(_x, _y, _z) * _scale
	var ui := Vector2(display_mesh.mesh.size.x * display_mesh.scale.x, display_mesh.mesh.size.y * display_mesh.scale.y)
	
	target_position.x = _calculate_position(ui.x, _body.x, anchor_x, margin.x)
	target_position.z = _calculate_position(0, _body.z, anchor_z, margin.z)
	
	target_position.y = _calculate_position(ui.y, _body.y, anchor_y, margin.y)
	
	# If the UI is bigger than the mesh itself
	if target_position.y + ui.y / 2.0 < body.position.y + _body.y / 2.0:
		print("default position")
		target_position.y = (ui.y - _body.y) / 2.0 + margin.y
	
	return target_position


func _calculate_position(_ui: float, _body_2: float, _anchor: Anchor, _margin: float) -> float:
	var result: float
	result = _anchor * (_body_2 + _ui + _margin) / 2.0
	return result


func show_ui(_player: Player) -> void:
	if not visible:
		visible = true
		set_process(true)
		if player == null:
			player = _player



func hide_ui() -> void:
	visible = false
	set_process(false)



