extends Node2D

@export var emitters_path = []
var emitters = []
@export var lifetime : float
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, emitters_path.size()):
		emitters.push_back(get_node(emitters_path[i]))
		pass
	pass # Replace with function body.

func emit():
	for i in range(0, emitters.size()):
		emitters[i].restart()
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifetime -= delta
	if(lifetime <= 0):
		free()
		pass
	pass
