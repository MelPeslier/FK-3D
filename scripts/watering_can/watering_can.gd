class_name WateringCan
extends CharacterBody3D

const WATER_MIN: float = 0
const WATER_MAX: float = 1000
const OUTPUT_MIN: float = 1
const OUTPUT_MAX: float = 50

@export_category("Nodes")
@export var state_machine: FiniteStateMachine
@export var interactable: InteractableComponent

@export_category("Variables")
@export var gravity: float = 10

@export_category("Water")
@export_range(WATER_MIN, WATER_MAX) var water: float:
	set(val):
		water = clamp(val, WATER_MIN, WATER_MAX)

@export_range(OUTPUT_MIN, OUTPUT_MAX) var output: float

var layers_collision: Array[int]

var holder: Node3D

var flower: WaterFlower


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)
	
	# On donne 0 zone de collisions à l'élément
	# On laisse les états machine gérer l'activation ou non des zones de collisions
	layers_collision = init_layers_collision()
	disable_collision_layers()


func process_unhandled_input(event: InputEvent) -> void:
	state_machine.process_unhandled_input(event)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)


func _process(delta: float) -> void:
	state_machine.process_frame(delta)


# Water
func watering(delta: float) -> void:
	if not flower and not is_instance_valid(flower):
		return
	
	if water < 0.0001: 
		print("no water")
		return
	
	var output_value = min(water, output)
	water -= output_value * delta
	flower.watering(delta, output_value)


func _on_watering_can_interactor_component_item_received(obj) -> void:
	flower = obj


func _on_watering_can_interactor_component_item_unfocus() -> void:
	flower = null


# Collision layers visibility
func init_layers_collision() -> Array[int]:
	var tab: Array[int] = []
	for i in range(1, 33):
		if interactable.get_collision_layer_value(i):
			tab.append(i)
	return tab


func disable_collision_layers() -> void:
	alter_collision_layers(false)


func enable_collision_layers() -> void:
	alter_collision_layers(true)


func alter_collision_layers(do: bool) -> void:
	for i in layers_collision:
		interactable.set_collision_layer_value(i, do)


