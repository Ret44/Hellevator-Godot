extends RigidBody2D

var last_position : float

@onready var animator : AnimationTree = $AnimationTree

# Called when the node enters the scene tree for the first time.
func _ready():
	last_position = self.position.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(absf(last_position-self.position.x) > 0.5):
		animator["parameters/conditions/walking"] = true
		animator["parameters/conditions/idle"] = false
	else:
		animator["parameters/conditions/walking"] = false
		animator["parameters/conditions/idle"] = true
		pass
	last_position = self.position.x
	pass
