extends Node

var state : GameState
var state_path : NodePath

@export_node_path var splash_state : NodePath
@export_node_path var title_state : NodePath
@export_node_path var tutorial_state : NodePath
@export_node_path var gameplay_state : NodePath
@export_node_path var outro_state : NodePath
@export_node_path var game_over_state : NodePath 

# Called when the node enters the scene tree for the first time.
func _ready():
	set_state(gameplay_state)
	pass # Replace with function body.

func set_state(new_state_path, with_transition = false):
	if(state!=null):
		state.process_state_exit()
		pass
	var new_state = get_node(new_state_path)
	if(new_state!=null):
		state = new_state
		state_path = new_state_path
		state.process_state_enter()
		pass
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(state!=null):
		state.process_input(delta)
		state.process_state(delta)
		pass
	pass