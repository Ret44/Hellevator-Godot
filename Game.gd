extends Node

@export var state : GameState
var state_path : NodePath

@export_node_path var splash_state : NodePath
@export_node_path var title_state : NodePath
@export_node_path var tutorial_state : NodePath
@export_node_path var gameplay_state : NodePath
@export_node_path var outro_state : NodePath
@export_node_path var game_over_state : NodePath 

# Called when the node enters the scene tree for the first time.
func _ready():
	set_state(gameplay_state, { Globals.ARGKEY_TUTORIAL : true }, UIManager.fade_transition, UIManager.door_transition)
	pass # Replace with function body.

func set_state(new_state_path, args = {}, in_transition = null, out_transition = null):
	var new_state = get_node(new_state_path)
	var func_exit = func (args):
		if(state!=null):
			state.process_state_exit()
			pass
		pass	
	var func_enter = func (args):
		if(new_state!=null):
			state = new_state
			state_path = new_state_path
			state.process_state_enter(args)
			pass	
	
	if in_transition == null:
		func_exit.call(args)
		func_enter.call(args)
		if out_transition != null:
			out_transition.enter(null,null)
	else:
		var lmbd = func (args):
			func_exit.call(args)
			func_enter.call(args)
			if out_transition != null:
				in_transition.reset()
				out_transition.enter(null, null)
		in_transition.exit(lmbd, args)
		pass
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(state!=null):
		state.process_input(delta)
		state.process_state(delta)
		pass
	pass
