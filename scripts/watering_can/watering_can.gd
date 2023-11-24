class_name WateringCan
extends CharacterBody3D

signal dropped

const WATER_MIN: float = 0
const WATER_MAX: float = 1000
const OUTPUT_MIN: float = 1
const OUTPUT_MAX: float = 50

@export_category("Nodes")
@export var state_machine: FiniteStateMachine
@export var interactable: InteractableComponent

@export_category("Variables")
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@export_category("Water")
@export_range(WATER_MIN, WATER_MAX) var water: float:
	set(val):
		water = clamp(val, WATER_MIN, WATER_MAX)

@export_range(OUTPUT_MIN, OUTPUT_MAX) var output: float

var layers_collision: Array[int]
var holder: Node3D
var flower: WaterFlower

@onready var watering_can: Node3D = $watering_can


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)


func process_unhandled_input(event: InputEvent) -> void:
	state_machine.process_unhandled_input(event)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
	move_and_slide()


func _process(delta: float) -> void:
	state_machine.process_frame(delta)


func _update_direction(delta: float, direction: Vector3, target_direction: Vector3, coef: float) -> Vector3:
	var new_direction = direction.lerp(target_direction, delta * coef)
	return new_direction


# Water
func watering(delta: float) -> void:
	if not flower and not is_instance_valid(flower):
		return
	
	if water < 0.0001: 
		print("no water")
		return
	
	var output_value = min(water, output)
	water -= output_value * delta
	flower.water_component.add_water(delta, output_value)


func _on_watering_can_interactor_component_item_received(obj) -> void:
	flower = obj


func _on_watering_can_interactor_component_item_unfocus() -> void:
	flower = null


func modulate_item(_color: Color) -> void:
	# Only change the mesh albedo color
	var obj = watering_can.get_child(0) as MeshInstance3D
	var mat = obj.material_override as StandardMaterial3D
	mat.albedo_color = _color
	
	# Duplicate the mesh instance, grow it and change it's color
#	var new = obj.duplicate() as MeshInstance3D
#	watering_can.add_child(new)
#	new.material_override = StandardMaterial3D.new()
#	new.material_override.grow = true
#	new.material_override.grow_amount = 0.01
#	new.material_override.albedo_color = Color.BLUE_VIOLET






