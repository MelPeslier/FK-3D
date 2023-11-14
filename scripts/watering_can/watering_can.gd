class_name WateringCan
extends CharacterBody3D


@export var gravity: float = 10

var parent: Player
var layers_collision: Array[int]

@onready var state_machine = $InteractableFiniteStateMachine
@onready var interactable: Area3D = $Interactable


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)
	
	# On donne 0 zone de collisions à l'élément
	# On laisse les états machine gérer l'activation ou non des zones de collisions
	layers_collision = init_layers_collision()
	disable_collision_layers()


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)


func _process(delta: float) -> void:
	state_machine.process_frame(delta)



# Interactions
func _on_interactable_focused(interactor: Interactor) -> void:
	state_machine.on_interactable_focused(interactor)


func _on_interactable_interacted(interactor: Interactor) -> void:
	state_machine.on_interactable_interacted(interactor)


func _on_interactable_unfocused(interactor: Interactor) -> void:
	state_machine.on_interactable_unfocused(interactor)


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



