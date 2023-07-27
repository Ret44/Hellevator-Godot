class_name HotelFloor
extends Node2D

@export var floor : int
@export var spawned_guest : bool
# TODO : DoorMechanism
@export var is_lobby : bool

@export_node_path var background_left_path : NodePath
@onready var background_left : Sprite2D = get_node(background_left_path)
@export_node_path var background_right_path : NodePath
@onready var background_right : Sprite2D = get_node(background_right_path)

