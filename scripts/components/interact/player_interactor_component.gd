class_name PlayerInteractorComponent
extends InteractorComponent

@export var player: Player

var cached_closest: InteractableComponent


func _ready() -> void:
	area_exited.connect(_on_area_exited)
	controller = player


func _physics_process(_delta: float) -> void:
	var new_closest: InteractableComponent = get_closest_interactable()
	if new_closest != cached_closest:
		if is_instance_valid(cached_closest):
			unfocus(cached_closest)
		if new_closest:
			focus(new_closest)
	cached_closest = new_closest


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if is_instance_valid(cached_closest):
			interact(cached_closest)


func _on_area_exited(area: InteractableComponent) -> void:
	pass
#	if cached_closest == area:
#		print("area exited unfocus")
#		unfocus(area)
