extends GameState
class_name GameOverState

@export var gameover_scene_prefab : String
var gameover_scene

func _ready():
	pass # Replace with function body.

func process_state_enter(args):
	super(args)
	gameover_scene = load(gameover_scene_prefab).instantiate()
	Game.root_viewport.add_child(gameover_scene)
	var label_txt : String = "LIFT GIRL\nSavior of "+str(Game.people_saved)+" people\nHer last tip was "+str(Game.money)+"$"
	gameover_scene.label.set_text(label_txt)
	pass

func process_state_exit():
	super()
	Sounds.stop(Sounds.shake)
	gameover_scene.free()
	pass

func process_input(_delta):
	if Input.is_action_pressed("start"):
		Game.set_state(Game.gameplay_state, { Globals.ARGKEY_TUTORIAL : false }, UIManager.door_transition, UIManager.door_transition)
		pass
	pass

func process_state(_delta):
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
