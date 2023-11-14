class_name PlayerInteractor
extends Interactor

@export var player: CharacterBody3D

var cached_closest: Interactable

func _ready() -> void:
	area_exited.connect(_on_area_exited)
	controller = player


func _physics_process(_delta: float) -> void:
	var new_closest: Interactable = get_closest_interactable()
	if new_closest != cached_closest:
		if is_instance_valid(cached_closest):
			print("physics unfocus")
			unfocus(cached_closest)
		if new_closest:
			focus(new_closest)
	cached_closest = new_closest


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if is_instance_valid(cached_closest):
			interact(cached_closest)


func _on_area_exited(area: Interactable) -> void:
	pass
#	if cached_closest == area:
#		print("area exited unfocus")
#		unfocus(area)
