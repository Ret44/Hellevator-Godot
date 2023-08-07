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
	current_floor = int(round(position.y)) - 1
	process_movement(delta)
	process_doors(delta)
	
#	current_axis_value = 

	process_bell_girl_animation(delta)
	process_camera(delta)
	pass

func process_movement(delta):
	pass

func process_doors(delta):
	pass

func process_bell_girl_animation(delta):
	pass

func process_camera(delta):
	main_camera.position = self.position
	pass
