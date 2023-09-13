class_name HotelBuilding
extends Node2D

@export var floor_count : int = 5
@export var max_tilt : float = 25
@export var tilt_speed : float = 0.4
@export var tilt_pause : float = 0.5

@export var max_guests : int
@export var spawn_delay : float

@export_node_path var roof_path : NodePath
@export_node_path var lobby_path : NodePath
var lobby : HotelFloor

@export var floor_prefab_path : String
var floor_prefab
@export var guest_prefab_path : String
var guest_prefab

@export var tutorial_guest_prefab_path : String
var tutorial_guest_prefab
var tutorial_guest

@export var backgrounds_list = []
var backgrounds = []
@export var guests_animations_paths = []
var guest_animations = []
@export var guests = []
@export var spawners = []
@export var floors = []
@export_node_path var elevator_path : NodePath
var elevator

@export var safe_zone_ok_path : String
var safe_zone_ok
@export var safe_zone_broken_path : String
var safe_zone_broken 

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

@export var camera_path : NodePath
var camera

@export var is_tilting : bool
@export var is_spawning : bool
	
# Called when the node enters the scene tree for the first time.
func _ready():	
	floor_prefab = load(floor_prefab_path)
	guest_prefab = load(guest_prefab_path)
	tutorial_guest_prefab = load(tutorial_guest_prefab_path)
	floor_root = get_node(floor_root_path)
	lobby = get_node(lobby_path)
	maximum_point = get_node(maximum_point_path)
	minimum_point = get_node(minimum_point_path)
	camera = get_node(camera_path)
	elevator = get_node(elevator_path)

	maximum_point.set_position(Vector2(self.get_position().x, maximum_point.get_position().y))
	minimum_point.set_position(Vector2(self.get_position().x, minimum_point.get_position().y))
	
	for i in range(0, guests_animations_paths.size()):
		guest_animations.push_back(load(guests_animations_paths[i]))
		pass
	
	for i in range(0, backgrounds_list.size()):
		backgrounds.push_back(load(backgrounds_list[i]))
		pass
	
	safe_zone_ok = load(safe_zone_ok_path)
	safe_zone_broken = load(safe_zone_broken_path)
	
	prepare_floors()
	
	#if !skiptutorial SpawnTutorialguest
	
	pass # Replace with function body.

func set_lobby_broken(state):
	if state:
		lobby.set_background(safe_zone_broken)
	else:
		lobby.set_background(safe_zone_ok)
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_tilting : process_tilting(delta)
	if is_spawning : process_spawning(delta)
	pass

func prepare_floors():
	var new_floor : HotelFloor
	
	add_floor(lobby)
	
	for i in range(1, floor_count):
		new_floor = floor_prefab.instantiate()
		add_floor(new_floor)
		pass
	
	var roof = get_node(roof_path)
	roof.position = Vector2(roof.get_position().x, - 150 * floors.size() + 1)
	
	pass

func add_floor(new_floor):
	new_floor.set_position(Vector2(new_floor.get_position().x, - 2.5 - 150 * floors.size() + 1))
	new_floor.floor = floors.size()
	if(!new_floor.is_lobby):
		new_floor.name = "Floor " + str(new_floor.floor)
		new_floor.set_background(backgrounds[randi() % backgrounds.size()])
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
	

func process_tilting(delta):
	if(tilt_pause_timer < 0):
		tilt_timer += delta
		var new_sin_value = sin(tilt_timer * tilt_speed)
		set_rotation_degrees(new_sin_value * max_tilt)
		
		if((new_sin_value < previous_sin_value && !is_sin_decreasing) || (new_sin_value > previous_sin_value && is_sin_decreasing)):
			tilt_pause_timer = tilt_pause
			is_sin_decreasing = !is_sin_decreasing
			if(tilt_pause < 1.5):
				tilt_pause += 0.05
				tilt_speed += 0.03
				tilt_timer = (tilt_timer * (tilt_speed - 0.03)) / tilt_speed
				pass
			pass
		previous_sin_value = new_sin_value
		pass
	else:
		tilt_pause_timer -= delta
		pass	
	pass

func spawn_guest(spawner, is_tutorial = false):
	if !is_tutorial: print("[SPAWN] Spawning new guest ID" + str(guests.size()))
	else: print("[SPAWN] Spawning tutorial guest")
	var new_guest 
	if !is_tutorial: new_guest = guest_prefab.instantiate()
	else: new_guest = tutorial_guest_prefab.instantiate()
	new_guest.position = spawner.position;
	spawner.get_parent().get_parent().add_child(new_guest)
	if !is_tutorial:
		new_guest.randomize_value(spawner.floorID)
		new_guest.name = "GuestID" + str(guests.size())
		new_guest.animator.sprite_frames = load(guests_animations_paths[randi() % guests_animations_paths.size()])
		new_guest.animator.play()
		guests.push_back(new_guest)
	else:
		new_guest.name = "TutorialGuest"
		tutorial_guest = new_guest
		pass
	pass

func process_spawning(delta):
	spawn_delay_timer -= delta
	if(spawn_delay_timer <= 0):
	
		spawn_delay_timer = spawn_delay

		if(guests.size() < max_guests):
			print("[SPAWN] Spawning new guest ID" + str(guests.size()))
			var s = spawners[randi() % spawners.size()]
			spawn_guest(s, false)
			pass
		pass
	pass
	
	
