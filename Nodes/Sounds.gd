extends Node

@export_node_path var door_open : NodePath
@export_node_path var door_close : NodePath
@export_node_path var lever_left : NodePath
@export_node_path var lever_right : NodePath
@export_node_path var panic : NodePath


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play(sound_path, pitch = 1):
	var sound : AudioStreamPlayer2D = get_node(sound_path)
	if(sound == null):
		printerr("[ERROR] Sound "+sound_path+" not found")
	sound.play()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
