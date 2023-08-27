extends Area2D

@export var kick_direction : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if(body.is_in_group("Guests")):
		print(body.name + " entered " + self.name)
		body.drop()
		pass
	pass # Replace with function body.
