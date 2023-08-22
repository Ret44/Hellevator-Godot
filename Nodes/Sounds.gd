extends Node

@export_node_path var door_open : NodePath
@export_node_path var door_close : NodePath
@export_node_path var lever_left : NodePath
@export_node_path var lever_right : NodePath
@export_node_path var bell : NodePath
@export_node_path var panic : NodePath
@export_node_path var engine : NodePath
@export var cash = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play(sound_path, pitch = 1):
	var sound : AudioStreamPlayer2D
	if(typeof(sound_path) == TYPE_ARRAY):
		sound = get_node(sound_path[randi() % sound_path.size()])
	else:
		sound = get_node(sound_path)
		pass
	if(sound == null):
		printerr("[ERROR] Sound "+sound_path+" not found")
	sound.play()
	pass

func stop(sound_path):
	var sound : AudioStreamPlayer2D
	if(typeof(sound_path) == TYPE_ARRAY):
		sound = get_node(sound_path[randi() % sound_path.size()])
	else:
		sound = get_node(sound_path)
		pass
	if(sound == null):
		printerr("[ERROR] Sound "+sound_path+" not found")
	sound.stop()
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
