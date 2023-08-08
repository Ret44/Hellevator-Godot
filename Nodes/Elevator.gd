extends Node2D

@export var skyline : Node2D

@export var maximum_speed : float
@export var velocity : float
@export var door_speed : float # obsolete?
@export var spawn_distance : float 

@export var current_floor : int

# animations ?

@export var deadzone_mod : float

@export var extra_elevator_velocity : float
@export var current_weight : float

@export_node_path var main_camera_path : NodePath
var main_camera : Camera2D

var pressed_up : bool

@export_node_path var bell_girl_path : NodePath

var bell_girl_animator : AnimatedSprite2D

var last_axis_value : float
var previous_floor : int

# Called when the node enters the scene tree for the first time.
func _ready():
	main_camera = get_node(main_camera_path)
	pass # Replace with function body.

func set_weighth(val):
	current_weight += val
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if current state gameplay or tutorial
	if(Game.state_path == Game.gameplay_state):
		current_floor = int(round(position.y)) - 1
		process_movement(delta)
		process_doors(delta)
	
#		current_axis_value = 
		if(Input.is_action_just_pressed("elevator_up")):
			Sounds.play(Sounds.lever_left)
			pass
		if(Input.is_action_just_pressed("elevator_down")):
			Sounds.play(Sounds.lever_right)
			pass

		process_bell_girl_animation(delta)
		process_camera(delta)
	
	#	Game.state.game_scene.sky.position = Vector2(0,position.y * 0.2)
		pass
	pass

func process_movement(delta):
	if(Game.state_path == Game.gameplay_state || Game.state_path == Game.tutorial_state):
		var direction : int = 0
		if(Input.is_action_pressed("elevator_up")):
			direction = 1
			pass
		if(Input.is_action_pressed("elevator_down")):
			direction = -1
			pass
		if(direction == 0 && previous_floor != current_floor):
			Sounds.play(Sounds.bell)
			previous_floor = current_floor
			pass
		if(position.y <= Game.state.game_scene.hotel.maximum_point.position.y):
			position += Vector2(0,1) * maximum_speed * delta * direction
			velocity = maximum_speed * delta * direction
			pass
		if(position.y > Game.state.game_scene.hotel.maximum_point.position.y):
			position += Vector2(0,1) * velocity
			if(velocity > -0.2):
				velocity -= delta * 0.25
			else:
				velocity -= 0
				pass
			pass
		pass
	pass

func process_doors(delta):
	
	pass

func process_bell_girl_animation(delta):
	pass

func process_camera(delta):
	main_camera.position = self.position
	pass
