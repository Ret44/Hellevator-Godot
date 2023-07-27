extends Node2D

@export var floor_count : int = 5
@export var max_tilt : float = 25
@export var tilt_speed : float = 0.4
@export var tilt_pause : float = 0.5

@export var max_guests : int
@export var spawn_delay : float

@export var floor_prefab_path : String
var floor_prefab
@export var guest_prefab_path : String
#guest prefab
@export var tutorial_guest_prefab_path : String
#tutorial guest prefab


var guests = []
var spawners = []
var floors = []

@export_node_path var maximum_point_path : NodePath
var maximum_point : Node2D
@export_node_path var minimum_point_path : NodePath
var minimum_point : Node2D

var previous_sin_value : float
var tilt_timer : float
var tilt_pause_timer : float
var is_sin_decreasing : bool
var spawn_delay_timer : float

@export var floor_root_path : NodePath
var floor_root : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	floor_prefab = load(floor_prefab_path) 
	floor_root = get_node(floor_root_path)
	maximum_point = get_node(maximum_point_path)
	minimum_point = get_node(minimum_point_path)
	#maximum_point = get_node(maximum_point_path)
	#minimum_point = get_node(minimum_point_path)
	

	maximum_point.set_position(Vector2(self.get_position().x, maximum_point.get_position().y))
	minimum_point.set_position(Vector2(self.get_position().x, minimum_point.get_position().y))
	
	prepare_floors()
	
	#if !skiptutorial SpawnTutorialguest
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if current_state = gameplay
	process_tilting()
	process_spawning()
	pass

func prepare_floors():
	var new_floor
	
	new_floor = floor_prefab.instantiate()
	new_floor.is_lobby = true
	new_floor.floor = 0
	add_floor(new_floor)
	
	for i in range(0, floor_count):
		new_floor = floor_prefab.instantiate()
		add_floor(new_floor)
		pass	
	pass

func add_floor(new_floor):
	new_floor.set_position(Vector2(new_floor.get_position().x, 2.5 + 150 * floors.size() + 1))
	new_floor.floor = floors.size()
	if(!new_floor.is_lobby):
		new_floor.name = "Floor " + str(new_floor.floor)
		# set background left
		# set background right
		pass
	else:
		new_floor.name = "Lobby"
		pass
	floors.push_back(new_floor)
	floor_root.add_child(new_floor)
	maximum_point.set_position(new_floor.get_position())
	
	if(floors.size() == 1):
		minimum_point.set_position(new_floor.get_position() + Vector2(0, 0.4))
		pass
	pass
	

func process_tilting():
	pass
	
func process_spawning():
	pass
	
	
