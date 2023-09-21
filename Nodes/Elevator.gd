extends Node2D

signal on_floor_changed

@export var skyline : Node2D

@export var maximum_speed : float
@export var velocity : float
@export var door_speed : float # obsolete?
@export var spawn_distance : float 

@export var current_floor : int

@export var allow_movement : bool
@export var allow_doors : bool

var is_moving : bool = false

# animations ?

@export var deadzone_mod : float

@export var extra_elevator_velocity : float
@export var current_weight : float

@export_node_path var main_camera_path : NodePath
var main_camera : Camera2D

var pressed_up : bool

@export_node_path var bell_girl_path : NodePath

var bell_girl_animator : AnimatedSprite2D
	
@export var tutorial_buttons = []

var last_axis_value : float
var previous_floor : int

# Called when the node enters the scene tree for the first time.
func _ready():
	main_camera = get_node(main_camera_path)
	bell_girl_animator = get_node(bell_girl_path)
	for btn in range(0,4):
		get_node(tutorial_buttons[btn]).visible = false
	pass # Replace with function body.

func set_weighth(val):
	current_weight += val
	pass

func get_tutorial_button(btn):
	if(btn >= 0 && btn <= 4):
		return get_node(tutorial_buttons[btn])
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if current state gameplay or tutorial
	if(Game.state_path == Game.gameplay_state):
		current_floor = (position.y / (Game.state.game_scene.hotel.maximum_point.position.y / Game.state.game_scene.hotel.floor_count))
		if(current_floor >= Game.state.game_scene.hotel.floors.size()):
			current_floor = Game.state.game_scene.hotel.floors.size() - 1
			pass
		if allow_movement: process_movement(delta)
		if allow_doors: process_doors(delta)
	
#		current_axis_value = 
		if(Input.is_action_just_pressed("elevator_up")):
			Sounds.play(Sounds.lever_left)
			pass
		if(Input.is_action_just_pressed("elevator_down")):
			Sounds.play(Sounds.lever_right)
			pass

		process_bell_girl_animation(delta)
		process_camera(delta)
	
		Game.state.game_scene.sky.position = Vector2(0,position.y * 0.9)
		pass
	pass

func _on_floor_changed():
	previous_floor = current_floor
	UIManager.set_current_floor(current_floor)
	pass

func process_movement(delta):
	if(Game.state_path == Game.gameplay_state || Game.state_path == Game.tutorial_state):
		var maximum_point = Game.state.game_scene.hotel.maximum_point.position.y
		var minimum_point = Game.state.game_scene.hotel.minimum_point.position.y
		if(Input.is_action_pressed("elevator_up") && !Input.is_action_pressed("elevator_door_left") && !Input.is_action_pressed("elevator_door_right") && position.y > maximum_point):
			position.y -= maximum_speed * delta
			if(position.y < maximum_point):
				position.y = maximum_point
				pass
			pass
		if(Input.is_action_pressed("elevator_down") && !Input.is_action_pressed("elevator_door_left") && !Input.is_action_pressed("elevator_door_right") && position.y < minimum_point):
			position.y += maximum_speed * delta
			if(position.y > minimum_point):
				position.y = minimum_point
				pass
			pass
		if((Input.is_action_just_released("elevator_up") || Input.is_action_just_released("elevator_down")) && previous_floor != current_floor):
			Sounds.play(Sounds.bell)
			if(previous_floor != current_floor):
				on_floor_changed.emit()
				pass
			pass
		pass
		
		if(Input.is_action_just_pressed("elevator_up") || Input.is_action_just_pressed("elevator_down")):
			Sounds.play(Sounds.engine)
			is_moving = true
			pass
		
		if(Input.is_action_just_released("elevator_up") || Input.is_action_just_released("elevator_down")):
			Sounds.stop(Sounds.engine)
			is_moving = false
			pass
	pass

func process_doors(delta):
	if(Input.is_action_pressed("elevator_door_left")):
		var floor = Game.state.game_scene.hotel.floors[current_floor]
		if(!floor.is_lobby):
			floor.door_mechanism.open_left = true
			pass
		pass
	
	if(Input.is_action_just_released("elevator_door_left")):
		var floor = Game.state.game_scene.hotel.floors[current_floor]
		if(!floor.is_lobby):
			floor.door_mechanism.open_left = false
			pass
		pass
	
	if(Input.is_action_pressed("elevator_door_right")):
		var floor = Game.state.game_scene.hotel.floors[current_floor]
		if(!floor.is_lobby):
			floor.door_mechanism.open_right = true
			pass
		pass
		
	if(Input.is_action_just_released("elevator_door_right")):
		var floor = Game.state.game_scene.hotel.floors[current_floor]
		if(!floor.is_lobby):
			floor.door_mechanism.open_right = false
			pass
		pass
	pass

func process_bell_girl_animation(delta):
	if(Input.is_action_pressed("elevator_up")):
		bell_girl_animator.play("going_up")
	elif(Input.is_action_pressed("elevator_down")):
		bell_girl_animator.play("going_down")
	else:
		bell_girl_animator.play("idle")
		pass
	pass

func process_camera(delta):
	main_camera.position = Vector2(self.position.x, self.position.y - 100)
	pass


func _on_tutorial_guest_hold_body_entered(body):
	if(body.is_in_group("TutorialGuest")):
		Game.state.perform_tutorial(4)
	pass # Replace with function body.
