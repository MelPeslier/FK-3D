class_name InfoData
extends HBoxContainer

enum Type{
	WATER
}

const MIN_SIZE_X : float = 44
const MAX_SIZE_X : float = 265

@export_file("*.png") var icon_tex_path: String
@export var base_color: Color

@onready var icon_tex: TextureRect = $Icon/IconTex
@onready var icon: PanelContainer = $Icon
@onready var icon_up: PanelContainer = $IconUp
@onready var icon_down: PanelContainer = $IconDown
@onready var progress_bar: PanelContainer = $ProgressBar


func _ready() -> void:
	icon_tex.texture = load(icon_tex_path)
	icon.self_modulate = base_color
	progress_bar.color = base_color


func set_max_value(val: float, val_min: float, val_max: float) -> void:
	var new_val := remap(val, val_min, val_max, MIN_SIZE_X, MAX_SIZE_X)
	progress_bar.custom_minimum_size.x = new_val


func set_value(val: float, val_min: float, val_max: float) -> void:
	val = remap(val, val_min, val_max, 0, 1)
	val = clampf(val, 0, 1)
	progress_bar.edge = val


func set_decr_coef(val: float) -> void:
	icon_down.coef = val


func set_decr_value(val: float) -> void:
	pass


func set_incr_coef(val: float) -> void:
	icon_up.coef = val


func set_incr_value(val: float) -> void:
	pass


func set_min_perfect(val: float) -> void:
	progress_bar.thresh_1 = val


func set_max_perfect(val: float) -> void:
	progress_bar.thresh_2 = val
