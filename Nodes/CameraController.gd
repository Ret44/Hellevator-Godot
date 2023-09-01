extends Camera2D

@export var shake_timer : float
@export var shake_amount : float
@export var is_shaking : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shake(time):
	is_shaking = true
	shake_timer = time
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_shaking:
		shake_timer -= delta
		if(shake_timer <= 0):
			is_shaking = false
			set_offset(Vector2(0,0))
		else:
			set_offset(Vector2(randf_range(-1.0,1.0)*shake_amount, randf_range(-1.0,1.0)*shake_amount))
			pass
		pass
	pass
