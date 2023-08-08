extends GameState

class_name GameplayState

@export var game_scene_path : String
var game_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func process_state_enter():
	super()
	game_scene = load(game_scene_path).instantiate()
	get_tree().root.get_node("GameRoot").add_child(game_scene)
	game_scene._ready()
	pass

func process_state_exit():
	super()
	game_scene.free()
	pass
	
func process_input(delta):
	
	pass

func process_state(delta):
	pass
