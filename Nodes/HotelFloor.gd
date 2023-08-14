class_name HotelFloor
extends Node2D

@export var floor : int
@export var spawned_guest : bool
@export_node_path var door_mechanism_path : NodePath
var door_mechanism : DoorMechanism
@export var is_lobby : bool

@export_node_path var background_left_path : NodePath
@onready var background_left : Sprite2D = get_node(background_left_path)
@export_node_path var background_right_path : NodePath
@onready var background_right : Sprite2D = get_node(background_right_path)
@export_node_path var wall_left_collider_path : NodePath
var wall_left_collider : CollisionShape2D
@export_node_path var wall_right_collider_path : NodePath
var wall_right_collider : CollisionShape2D

func _ready():
	door_mechanism = get_node(door_mechanism_path)
	pass

func set_as_lobby():
	floor = 0
	is_lobby = true
	get_node(wall_left_collider_path).disabled = true
	get_node(wall_right_collider_path).disabled = true
	pass

func set_background(background):
	get_node(background_left_path).set_texture(background)
	get_node(background_right_path).set_texture(background)
	pass
