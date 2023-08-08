class_name GameState
extends Node


# Called whenG the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func process_state_enter():
	print("[STATE] Entering state :" + name)
	pass

func process_state_exit():
	print("[STATE] Exiting state :" + name)
	pass
	
func process_input(delta):
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
