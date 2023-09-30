extends Control

@export var duration : float

@export_node_path var left_door_path : NodePath
@export_node_path var right_door_path : NodePath

var tweener

func open(callback, args = null):
	var screensize = get_viewport().get_visible_rect().size.x
	tween(0, -(screensize/2), screensize/2, screensize, callback, args)
	pass
	
func close(callback, args = null):
	var screensize = get_viewport().get_visible_rect().size.x
	tween(-(screensize/2), 0, screensize, screensize/2, callback, args)
	pass

func tween(left_start, left_target, right_start, right_target, callback, args):
	if tweener != null:
		tweener.stop()
	#	tweener.queue_free()
		pass
	get_node(left_door_path).position.x = left_start
	get_node(right_door_path).position.x = right_start
	
	tweener = create_tween()
	tweener.tween_property(get_node(left_door_path), "position:x", left_target, duration)
	tweener.parallel().tween_property(get_node(right_door_path), "position:x", right_target, duration)
	tweener.chain().tween_interval(1)
	if callback != null:
		tweener.chain().tween_callback(callback.bind(args))
		pass
	tweener.play()
	pass

