extends Node2D

@export var emitters = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, emitters.size()):
		emitters[i] = get_node(emitters[i])
		pass
	pass # Replace with function body.

func emit():
	for i in range(0, emitters.size()):
		emitters[i].restart()
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
