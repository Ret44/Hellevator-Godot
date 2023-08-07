extends Node2D

@export var floor_count : int = 5
@export var max_tilt : float = 25
@export var tilt_speed : float = 0.4
@export var tilt_pause : float = 0.5

@export var max_guests : int
@export var spawn_delay : float

@export_node_path var lobby_path : NodePath
var lobby : HotelFloor

@export var floor_prefab_path : String
var floor_prefab
@export var guest_prefab_path : String
#guest prefab
@export var tutorial_guest_prefab_path : String
#tutorial guest prefab

@export var backgrounds_list = []
var backgrounds = []
@export var guests_animations_paths = []
var guest_animations = []
@export var spawners = []
@export var floors = []

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

# Called when the node enters the scene tree for the first time.
func _ready():
	floor_prefab = load(floor_prefab_path) 
	floor_root = get_node(floor_root_path)
	lobby = get_node(lobby_path)
	maximum_point = get_node(maximum_point_path)
	minimum_point = get_node(minimum_point_path)
	#maximum_point = get_node(maximum_point_path)
	#minimum_point = get_node(minimum_point_path)
		
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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if current_state = gameplay
	if(Input.is_action_just_pressed("elevator_door_left")):
		Sounds.play(Sounds.door_open)
		pass
	
	process_tilting(delta)
	process_spawning(delta)
	pass

func prepare_floors():
	var new_floor : HotelFloor
	
	#new_floor = floor_prefab.instantiate()
	#new_floor.set_as_lobby()
	#new_floor.set_background(safe_zone_broken)
	#add_floor(new_floor)
	
	add_floor(lobby)
	
	
	for i in range(1, floor_count):
		new_floor = floor_prefab.instantiate()
		add_floor(new_floor)
		pass	
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
	"""
			// calculate tilt timer
		if (tiltPauseTimer < 0) {
			tiltTimer += Time.deltaTime;

			// tilt the building
			float newSinValue = Mathf.Sin(tiltTimer * tiltSpeed);
			transform.rotation = Quaternion.Euler(0, 0, newSinValue * maxTilt);

			// check for tilt pause
			if ((newSinValue < previousSinValue && !isSinDecreasing) || (newSinValue > previousSinValue && isSinDecreasing)) {
				tiltPauseTimer = tiltPause;
				isSinDecreasing = !isSinDecreasing;
				if (tiltPause < 1.5f) {
					tiltPause += 0.06f;
					tiltSpeed += 0.03f;
					tiltTimer = (tiltTimer * (tiltSpeed - 0.03f)) / tiltSpeed; 
				}
			}
			previousSinValue = newSinValue;
		}
		else {
			tiltPauseTimer -= Time.deltaTime;
		}
	"""
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
	
func process_spawning(delta):
	pass
	
	
