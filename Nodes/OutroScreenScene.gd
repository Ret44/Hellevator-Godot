extends Node


func on_animation_trigger():
	UIManager.fade_transition.color = Color(1,1,1,1)
	Game.set_state(Game.title_state, {}, UIManager.fade_transition, UIManager.fade_transition)
	pass
