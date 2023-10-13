extends GameState
class_name TitleScreenState

@export var title_scene_prefab : String
var title_scene

func _ready():
	pass # Replace with function body.

func process_state_enter(args):
	super(args)
	title_scene = load(title_scene_prefab).instantiate()
	Game.root_viewport.add_child(title_scene)
	Sounds.play(Sounds.city_atmo)
	pass

func process_state_exit():
	super()
	Sounds.stop(Sounds.city_atmo)
	title_scene.free()
	pass

func process_input(_delta):
	if Input.is_action_pressed("start"):
		Game.set_state(Game.gameplay_state, { Globals.ARGKEY_TUTORIAL : true }, UIManager.door_transition, UIManager.door_transition)
		pass
	pass

func process_state(_delta):
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
