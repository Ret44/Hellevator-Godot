extends GameState
class_name SplashScreenState

@export var splash_scene_prefab : String
@export var interval_between_cards : float
@export var interval_during_tween : float
var splash_scene

var tweener

func _ready():
	pass # Replace with function body.

func process_state_enter(args):
	super(args)	
	splash_scene = load(splash_scene_prefab).instantiate()
	get_tree().root.get_node("GameRoot").add_child(splash_scene)
	tweener = create_tween()
	tweener.tween_interval(interval_between_cards)
	tweener.chain().tween_property(splash_scene.splash_01, "modulate", Color(1,1,1,1), interval_during_tween)
	tweener.chain().tween_interval(interval_between_cards)
	tweener.chain().tween_property(splash_scene.splash_02, "modulate", Color(1,1,1,1), interval_during_tween)
	tweener.chain().tween_interval(interval_between_cards)
	tweener.chain().tween_property(splash_scene.splash_03, "modulate", Color(1,1,1,1), interval_during_tween)
	tweener.chain().tween_interval(interval_between_cards)
	tweener.chain().tween_property(splash_scene.splash_04, "modulate", Color(1,1,1,1), interval_during_tween)
	tweener.chain().tween_interval(interval_between_cards)
	tweener.chain().tween_callback(on_animation_completed)
	tweener.play()
	pass

func on_animation_completed():
	UIManager.fade_transition.color = Color(0,0,0,1)
	Game.set_state(Game.title_state, {}, UIManager.fade_transition, UIManager.door_transition)
	pass

func process_state_exit():
	super()
	splash_scene.free()
	pass

func process_input(_delta):
	pass

func process_state(_delta):
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
