class_name Flower
extends CharacterBody3D

@export var in_game_ui: InGameUi




# Passing collision detection to the concerned part
func show_ui(player: Player) -> void:
	in_game_ui.show_ui(player)


func hide_ui() -> void:
	in_game_ui.hide_ui()
