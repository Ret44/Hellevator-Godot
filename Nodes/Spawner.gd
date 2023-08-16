class_name Spawner
extends Node2D

var hotel_floor : HotelFloor
var floorID = 0 : get = get_floor_id

func get_floor_id():
	return hotel_floor.floor
	
# Called when the node enters the scene tree for the first time.
func _ready():
	hotel_floor = get_parent().get_parent()
	if(!hotel_floor.is_lobby):
		Game.state.game_scene.hotel.spawners.push_back(self)
		pass
	pass # Replace with function body.
