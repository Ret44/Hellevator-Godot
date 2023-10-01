extends GameState
class_name OutroState

@export var outro_scene_prefab : String
var outro_scene

func _ready():
	pass # Replace with function body.

func process_state_enter(args):
	super(args)
	outro_scene = load(outro_scene_prefab).instantiate()
	get_tree().root.get_node("GameRoot").add_child(outro_scene)
	Sounds.play(Sounds.shake)
	pass

func process_state_exit():
	super()
	outro_scene.free()
	pass

func process_input(_delta):
	pass

func process_state(_delta):
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
