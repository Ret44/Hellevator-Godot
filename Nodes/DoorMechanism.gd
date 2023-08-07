extends Node2D

@export_node_path var door_left_collider_path : NodePath
@onready var door_left_collider = get_node(door_left_collider_path)
@export_node_path var door_right_collider_path : NodePath
@onready var door_right_collider = get_node(door_right_collider_path)
@export_node_path var door_left_animation_path : NodePath
@onready var door_left_animation = get_node(door_left_animation_path)
@export_node_path var door_right_animation_path : NodePath
@onready var door_right_animation = get_node(door_right_animation_path)

@export var is_enabled : bool

@export var open_left : bool
@export var open_right : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if(!is_enabled):
		door_left_collider.disabled = true
		door_right_collider.disabled = true
		pass
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_enabled):
		if(open_left && !door_left_collider.disabled):
			door_left_collider.disabled = true
			door_left_animation.play("door_open")
			Sounds.play(Sounds.door_open)
			pass
		if(!open_left && door_left_collider.disabled):
			door_left_collider.disabled = false
			door_left_animation.play("door_close")
			Sounds.play(Sounds.door_close)
			pass
		if(open_right && !door_right_collider.disabled):
			door_right_collider.disabled = true
			door_right_animation.play("door_open")
			Sounds.play(Sounds.door_open)
			pass
		if(!open_right && door_right_collider.disabled):
			door_right_collider.disabled = false
			door_right_animation.play("door_close")
			Sounds.play(Sounds.door_close)
			pass
		pass
	pass
