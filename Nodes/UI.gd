class_name UI
extends Node

@export_node_path var current_floor_path : NodePath
var current_floor : Label

@export_node_path var dudes_counter_path : NodePath
var dudes_counter : Label
var dudes_counter_value : int = 0

@export_node_path var timer_path : NodePath
var timer : Label

@export_node_path var money_counter_path : NodePath
var money_counter : Label
var money_value : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	current_floor = get_node(current_floor_path)
	dudes_counter = get_node(dudes_counter_path)
	timer = get_node(timer_path)
	money_counter = get_node(money_counter_path)
	pass # Replace with function body.

func set_current_floor(value):
	current_floor.text = str(value)
	pass

func add_dude():
	set_dudes(dudes_counter_value+1)
	pass
	
func set_dudes(value):
	dudes_counter_value = value
	dudes_counter.set_text("Dudes: %i" % dudes_counter_value)
	pass

func add_money(value):
	set_money(money_value+value)
	pass
	
func set_money(value):
	money_value = value
	money_counter.set_text("Money: %i" % money_value)
	pass
