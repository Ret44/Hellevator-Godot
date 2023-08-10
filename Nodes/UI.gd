class_name UI
extends Node

@export_node_path var current_floor_path : NodePath
var current_floor : Label


# Called when the node enters the scene tree for the first time.
func _ready():
	current_floor = get_node(current_floor_path)
	pass # Replace with function body.

func set_current_floor(value):
	current_floor.text = str(value)
	pass
