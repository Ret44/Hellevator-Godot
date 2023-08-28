class_name UI
extends Node

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

@export_node_path var time_minutes_digit1 : NodePath
@export_node_path var time_minutes_digit2 : NodePath
@export_node_path var time_seconds_digit1 : NodePath
@export_node_path var time_seconds_digit2 : NodePath


# Called when the node enters the scene tree for the first time.
func _ready():
	current_floor = get_node(current_floor_path)
	dudes_counter = get_node(dudes_counter_path)
	timer = get_node(timer_path)
	money_counter = get_node(money_counter_path)
	var dude_prefab = load(dude_prefab_path)
	var dude_container = get_node(dude_container_path)
	for i in range(0, 88):
		var dude = dude_prefab.instantiate()
		dude_container.add_child(dude)
		dude_counter.push_back(dude)
		dude.visible = false
		pass
	pass # Replace with function body.

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
