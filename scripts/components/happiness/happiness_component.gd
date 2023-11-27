class_name HappinessComponent
extends Node

signal happ_changed(val: float)
signal happ_decr_coef_changed(val: float)
signal happ_decr_value_changed(val: float)
signal happ_incr_coef_changed(val: float)
signal happ_incr_value_changed(val: float)
signal zero_happiness()

const MIN: float = 0
const MAX: float = 100
const E := 0.001

@export_range(MIN, MAX) var happiness: float:
	set(new_value):
		happiness = clamp(new_value, MIN, MAX)
		happ_changed.emit(happiness)
		
		if happiness < MIN + E:
			zero_happiness.emit()


@export_category("Decrease")
@export var decrease_coef: float = 1:
	set(new_value):
		decrease_coef = new_value
		happ_decr_coef_changed.emit(decrease_coef)

@export var decrease_value: float:
	set(new_value):
		decrease_value = new_value
		happ_decr_value_changed.emit(decrease_value)


@export_category("Increase")
@export var increase_coef: float = 1:
	set(new_value):
		increase_coef = new_value
		happ_incr_coef_changed.emit(increase_coef)

@export var increase_value: float:
	set(new_value):
		increase_value = new_value
		happ_incr_value_changed.emit(increase_value)

# Environment modifiers
const SUB_NEARBY: float = 1.0
const ADD_NEARBY: float = -0.5

const SUB_GROUND: float = 0.6
const ADD_GROUND: float = -0.4

var sub_env_modifier: float = 1
var add_env_modifier: float = 1


func _ready() -> void:
	_init_values()


func sub_happ(delta: float, decr: float = decrease_value) -> void:
	happiness -= decr * decrease_coef * sub_env_modifier * delta


func add_happ(delta: float, incr: float = increase_value ) -> void:
	happiness += incr * increase_coef * add_env_modifier * delta


func alter_decrease_coef(old_value: float, new_value: float) -> void:
	decrease_coef -= old_value
	decrease_coef += new_value


func alter_increase_coef(old_value: float, new_value: float) -> void:
	increase_coef -= old_value
	increase_coef += new_value


func alter_nearby(activate_malus: bool) -> void:
	if activate_malus:
		add_env_modifier += ADD_NEARBY
		sub_env_modifier += SUB_NEARBY
	else:
		add_env_modifier -= ADD_NEARBY
		sub_env_modifier -= SUB_NEARBY


func alter_ground(activate_malus: bool) -> void:
	if activate_malus:
		add_env_modifier += ADD_GROUND
		sub_env_modifier += SUB_GROUND
	else:
		add_env_modifier -= ADD_GROUND
		sub_env_modifier -= SUB_GROUND


func is_happ_max() -> bool:
	var it_is := false
	if happiness > MAX - E:
		it_is = true
	return it_is


func _init_values() -> void:
	happiness = happiness
	decrease_coef = decrease_coef
	decrease_value = decrease_value
	increase_coef = increase_coef
	increase_value = increase_value
