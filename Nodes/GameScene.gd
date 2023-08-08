class_name GameScene
extends Node

@export_node_path var sky_path : NodePath
var sky : Node2D
@export_node_path var ground_path : NodePath
var ground : Node2D
@export_node_path var hotel_path : NodePath
var hotel : HotelBuilding
# Called when the node enters the scene tree for the first time.
func _ready():
	sky = get_node(sky_path)
	ground = get_node(ground_path)
	hotel = get_node(hotel_path)
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
