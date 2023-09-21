extends RigidBody2D

var last_position : float
@export var is_moving : bool = false
@export var walking_speed : float = 175

@onready var animator : AnimationTree = $AnimationTree

var tweener

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func move_to_elevator():
	animator["parameters/conditions/walking"] = true
	animator["parameters/conditions/idle"] = false
	tweener = get_tree().create_tween()
	tweener.tween_property(self, "position", Vector2(0, self.position.y), 1)
	tweener.tween_callback(on_move_to_elevator_complete)
	self.freeze = true
	pass
	
func on_move_to_elevator_complete():
	print("GUEST_COMPLETE")
	animator["parameters/conditions/walking"] = false
	animator["parameters/conditions/idle"] = true
	Game.state.perform_tutorial(4)
	self.freeze = false
	pass

func move_outside():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if is_moving:
#		self.position.x -= walking_speed * delta
#		pass
#	if(absf(last_position-self.position.x) > 0.25 || is_moving):
#		animator["parameters/conditions/walking"] = true
#		animator["parameters/conditions/idle"] = false
#	elif(absf(last_position-self.position.x) <= 0.25 || !is_moving):
#		animator["parameters/conditions/walking"] = false
#		animator["parameters/conditions/idle"] = true
#		pass
#	last_position = self.position.x
	pass
