class_name UI
extends Node

@export_node_path var ui_root_path : NodePath
var ui_root

@export_node_path var current_floor_path : NodePath
var current_floor : TextureRect

@export_node_path var dudes_counter_path : NodePath
var dudes_counter : Label
var dudes_counter_value : int = 0

@export_node_path var timer_path : NodePath
var timer : Label

@export var dude_prefab_path : String
@export var dude_counter = []
@export_node_path var dude_container_path : NodePath

@export_node_path var money_counter_path : NodePath
var money_counter : Label
var money_value : int = 0

@export_node_path var time_minutes_digit1_path : NodePath
@export_node_path var time_minutes_digit2_path : NodePath
@export_node_path var time_seconds_digit1_path : NodePath
@export_node_path var time_seconds_digit2_path : NodePath

var time_minutes_digit1
var time_minutes_digit2
var time_seconds_digit1
var time_seconds_digit2

@export_node_path var save_the_guests_path : NodePath

var save_the_guests

@export_node_path var transition_path : NodePath

var transition

var ui_tweener
var stg_tweener

# Called when the node enters the scene tree for the first time.
func _ready():
	ui_root = get_node(ui_root_path)
	current_floor = get_node(current_floor_path)
	dudes_counter = get_node(dudes_counter_path)
	timer = get_node(timer_path)
	money_counter = get_node(money_counter_path)
	var dude_prefab = load(dude_prefab_path)
	var dude_container = get_node(dude_container_path)
	time_minutes_digit1 = get_node(time_minutes_digit1_path)
	time_minutes_digit2 = get_node(time_minutes_digit2_path)
	time_seconds_digit1 = get_node(time_seconds_digit1_path)
	time_seconds_digit2 = get_node(time_seconds_digit2_path)
	save_the_guests = get_node(save_the_guests_path)
	transition = get_node(transition_path)
	for i in range(0, 88):
		var dude = dude_prefab.instantiate()
		dude_container.add_child(dude)
		dude_counter.push_back(dude)
		dude.visible = false
		pass
	pass # Replace with function body.

func open_transition(callback, args):
	get_node(transition_path).open(callback, args)
	pass
	
func close_transition(callback, args):
	get_node(transition_path).close(callback, args)
	pass

func set_current_floor(value):
	var rect = Rect2(((value % 3) * 150), ((value / 3) * 150) + (value * 150) % 3, 150, 150)
	current_floor.texture.set_region(rect)
	pass

func add_dude():
	set_dudes(dudes_counter_value+1)
	pass
	
func set_dudes(value):
	for i in range(0, dude_counter.size()):
		if(value < i):
			dude_counter[i].visible = false
		else:
			dude_counter[i].visible = true
			pass
		pass
	pass

func add_money(value):
	set_money(money_value+value)
	pass
	
func set_money(value):
	money_value = value
	money_counter.set_text(str(money_value))
	pass

func set_time(value):
	var minutes = floori(value / 60)
	var seconds = ceili(fmod(value, 60))
	if(seconds == 60):
		seconds = 0
		minutes += 1
		pass
	time_minutes_digit1.set_text(str(minutes / 10))
	time_minutes_digit2.set_text(str(minutes % 10))
	time_seconds_digit1.set_text(str(seconds / 10))
	time_seconds_digit2.set_text(str(seconds % 10))
	pass

func show_hud(instant):
	stop_tweener()
	if instant:
		ui_root.modulate = Color(1,1,1,1)
	else:
		tween_hud(Color(1,1,1,0), Color(1,1,1,1), 1)
		pass
	pass

func show_save_the_guest():
	save_the_guests.modulate = Color(1,1,1,0)
	if(stg_tweener != null):
		stg_tweener.stop()
		stg_tweener.free()
		pass
	stg_tweener = create_tween()
	stg_tweener.tween_property(save_the_guests, "modulate", Color(1,1,1,1), 1)
	stg_tweener.tween_interval(3)
	stg_tweener.tween_property(save_the_guests, "modulate", Color(1,1,1,0), 1)
	stg_tweener.play()
	pass

func hide_hud(instant):
	stop_tweener()
	if instant:
		ui_root.modulate = Color(1,1,1,0)
	else:
		tween_hud(Color(1,1,1,1), Color(1,1,1,0), 1)
		pass
	pass

func tween_hud(from, to, time):
	ui_root.modulate = from
	ui_tweener = create_tween()
	ui_tweener.tween_property(ui_root, "modulate", to, time)
	ui_tweener.play()
	pass

func stop_tweener():
	if(ui_tweener != null):
		ui_tweener.stop()
		ui_tweener.free()
		pass
	pass
