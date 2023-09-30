extends Control

@export var duration : float
@export var color : Color
@export_node_path var fade_path : NodePath

var tweener

func reset():
	get_node(fade_path).modulate = Color(color.r, color.g, color.b, 0)
	pass

func enter(callback, args = null):
	tween(Color(color.r, color.g, color.b, 1), Color(color.r, color.g, color.b, 0), callback, args)
	pass

func exit(callback, args = null):
	tween(Color(color.r, color.g, color.b, 0), Color(color.r, color.g, color.b, 1), callback, args)
	pass

func tween(start_color, target_color, callback, args):
	if tweener != null:
		tweener.stop()
		pass
	get_node(fade_path).modulate = start_color

	tweener = create_tween()
	tweener.tween_property(get_node(fade_path), "modulate", target_color, duration)
	tweener.chain().tween_interval(0.1)
	if callback != null:
		tweener.chain().tween_callback(callback.bind(args))
		pass
	tweener.play()
	pass

