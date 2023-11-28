class_name HappinessComponent
extends Node

signal happ_max_changed(val: float, min_max: float, max_max: float)
signal happ_changed(val: float, val_min: float, val_max: float)
signal happ_decr_coef_changed(val: float)
signal happ_decr_value_changed(val: float)
signal happ_incr_coef_changed(val: float)
signal happ_incr_value_changed(val: float)
signal zero_happiness
signal full_happiness
signal normal_happiness

const MIN: float = 0
const E := 0.001

@export_category("Max")
@export var min_max: float = 25
@export var max_max: float = 150
@export var happ_max: float = 50:
	set(new_value):
		happ_max = clampf(new_value, min_max, max_max)
		happ_max_changed.emit(happ_max, min_max, max_max)

@export_category("Bonus & Malus Coefs")
@export var bonus_max_coef: float = 4
@export var malus_max_coef: float = 3


@export_category("Happiness")
@export var happiness: float:
	set(new_value):
		happiness = clampf(new_value, MIN, happ_max)
		happ_changed.emit(happiness, MIN, happ_max)
		normal_happiness.emit()


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


@export_category("Timers")
@export var zero_wait_time: float = 30
@export var full_wait_time: float = 45


# Environment modifiers
const SUB_NEARBY: float = 1.0
const ADD_NEARBY: float = -0.5

const SUB_GROUND: float = 0.6
const ADD_GROUND: float = -0.4

var sub_env_modifier: float = 1
var add_env_modifier: float = 1


# Bonus & Malus
var bonus_max: float
var malus_max: float

# Timer related
var happ_is_normal := false

@onready var zero_timer := Timer.new()
@onready var full_timer := Timer.new()


func _ready() -> void:
	_init_values()
	_init_bonus()
	_init_timers()




func sub_happ(delta: float, decr: float = decrease_value) -> void:
	if happiness < MIN + E: return
	happiness -= decr * decrease_coef * sub_env_modifier * delta
	if happiness < MIN + E:
		zero_happiness.emit()


func add_happ(delta: float, incr: float = increase_value ) -> void:
	if happiness > happ_max - E: return
	happiness += incr * increase_coef * add_env_modifier * delta
	if happiness > happ_max - E:
		full_happiness.emit()


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
	return happiness > happ_max - E


func _init_values() -> void:
	happ_max = happ_max
	happiness = happiness
	decrease_coef = decrease_coef
	decrease_value = decrease_value
	increase_coef = increase_coef
	increase_value = increase_value


func _init_bonus() -> void:
	var diff = max_max - min_max
	bonus_max = diff / bonus_max_coef
	malus_max = diff / malus_max_coef


# Timers
func _init_timers() -> void:
	normal_happiness.connect(_on_normal_happiness)
	zero_happiness.connect(_on_zero_happiness)
	full_happiness.connect(_on_full_happiness)
	
	zero_timer.autostart = false
	zero_timer.one_shot = true
	zero_timer.process_callback = Timer.TIMER_PROCESS_IDLE
	zero_timer.timeout.connect(_on_zero_timer_timeout)
	add_child(zero_timer)
	
	full_timer.autostart = false
	full_timer.one_shot = true
	full_timer.process_callback = Timer.TIMER_PROCESS_IDLE
	full_timer.timeout.connect(_on_full_timer_timeout)
	add_child(full_timer)


func _on_normal_happiness() -> void:
	if happ_is_normal: return
	happ_is_normal = true
	zero_timer.stop()
	full_timer.stop()


func _on_zero_happiness() -> void:
	happ_is_normal = false
	zero_timer.start(zero_wait_time)


func _on_zero_timer_timeout() -> void:
	happ_max -= malus_max
	
	if happ_max > min_max + E:
		zero_happiness.emit()


func _on_full_happiness() -> void:
	happ_is_normal = false
	full_timer.start(full_wait_time)


func _on_full_timer_timeout() -> void:
	happ_max += bonus_max




