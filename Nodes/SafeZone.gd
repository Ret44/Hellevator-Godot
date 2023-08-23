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
		var particles = Game.state.coin_particle.instantiate()
		particles.position = body.position
		body.get_parent().add_child(particles)
		body.apply_impulse(Vector2(1000 * kick_direction, 0))
		Sounds.play(Sounds.cash)
		pass
	pass # Replace with function body.
