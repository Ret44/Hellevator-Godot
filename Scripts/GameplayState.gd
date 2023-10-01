extends GameState

class_name GameplayState

@export var game_scene_path : String
var game_scene
@export var people_saved : int = 0
@export var money : int = 0
@export var coin_particle_path : String
var coin_particle_prefab
@export var money_particle_path : String
var money_particle_prefab

@export var round_time : float
var timer

var tutorial_stage = -1
var tutorial_guest

# Called when the node enters the scene tree for the first time.
func _ready():
	coin_particle_prefab = load(coin_particle_path)
	money_particle_prefab = load(money_particle_path)
	pass # Replace with function body.

func process_state_enter(args):
	super(args)
	game_scene = load(game_scene_path).instantiate()
	game_scene._ready()
	get_tree().root.get_node("GameRoot").add_child(game_scene)
	timer = round_time
	if args[Globals.ARGKEY_TUTORIAL]:
		await get_tree().process_frame
		perform_tutorial(1)
	else:
		await get_tree().process_frame
		start_game()
		pass
	pass

func add_money(value):
	set_money(money + value)
	pass
	
func set_money(value):
	money = value
	UIManager.set_money(money)
	pass

func add_dude():
	set_dudes(people_saved+1)
	pass
	
func set_dudes(value):
	people_saved = value
	UIManager.set_dudes(value)
	pass

func process_state_exit():
	super()
	game_scene.free()
	pass

func start_game():
	tutorial_stage = -1
	game_scene.camera.shake(2.5)
	UIManager.show_hud(false)
	game_scene.hotel.set_lobby_broken(true)
	game_scene.hotel.is_tilting = true
	game_scene.hotel.is_spawning = true
	game_scene.hotel.elevator.allow_doors = true
	game_scene.hotel.elevator.allow_movement = true
	game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.UP).visible = false
	game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.DOWN).visible = false
	game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.LEFT).visible = false
	game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.RIGHT).visible = false
	if(tutorial_guest != null):
		tutorial_guest.free()
	pass

func on_tutorial_elevator_arrived():
	print("GAMESTATE SIGNAL")
	pass

func process_input(_delta):
	
	pass

func process_state(delta):
	if(tutorial_stage > -1): progress_tutorial(delta)
	else: progress_gameplay(delta)
	pass
	
func progress_gameplay(delta):
	if(timer > 0):
		timer -= delta
		if(timer <= 0):
			timer = 0
			pass
		UIManager.set_time(timer)
		pass
	pass	

func perform_tutorial(stage):
	tutorial_stage = stage
	match stage:
		1: # Step 1: Player moves elevator to upper level
			UIManager.hide_hud(true)
			game_scene.hotel.set_lobby_broken(false)
			game_scene.hotel.is_tilting = false
			game_scene.hotel.is_spawning = false
			game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.UP).visible = true
			game_scene.hotel.elevator.on_floor_changed.connect(on_tutorial_elevator_arrived)
			spawn_tutorial_guest()
		2: # Step 2: Player opens door for the guest
			game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.UP).visible = false
			game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.RIGHT).visible = true
			game_scene.hotel.elevator.allow_movement = false
		3: # Step 3: Player waits for the guest to enter the elevator
			game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.RIGHT).visible = false
			game_scene.hotel.elevator.allow_doors = false
			game_scene.hotel.tutorial_guest.start_moving()
		4: # Step 4: Player moves elevator with the guest to the lobby
			game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.DOWN).visible = true
			game_scene.hotel.elevator.allow_doors = true
			game_scene.hotel.elevator.allow_movement = true
			Game.state.game_scene.hotel.floors[2].door_mechanism.open_right = false
		5: # Step 5: Player waits as the guest exit elevator and leaves the hotel
			game_scene.hotel.elevator.allow_movement = false
			game_scene.hotel.elevator.allow_doors = false
			game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.DOWN).visible = false
			Game.state.game_scene.hotel.floors[0].door_mechanism.open_left = true
			Sounds.stop(Sounds.engine) # dirty workaround
			game_scene.hotel.tutorial_guest.start_moving()
		6: # Step 6: Tutorial ends, game starts
			Game.state.game_scene.hotel.floors[0].door_mechanism.open_left = false
			UIManager.show_save_the_guest()
			start_game()
	pass
	
func spawn_tutorial_guest():
	var tutorial_spawner
	for i in range(0,game_scene.hotel.spawners.size()):
		if game_scene.hotel.spawners[i].name == "2SpawnerP1":
			tutorial_spawner = game_scene.hotel.spawners[i]
			break
		pass
	if tutorial_spawner != null:
		game_scene.hotel.spawn_guest(tutorial_spawner, true)
		pass
	pass

func progress_tutorial(_delta):
	match tutorial_stage:
		1:  
			if game_scene.hotel.elevator.position.y > -210:
				game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.UP).visible = true
				game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.DOWN).visible = false
				pass
			elif game_scene.hotel.elevator.position.y <= -210 && game_scene.hotel.elevator.position.y >= -310:
				game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.UP).visible = false
				game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.DOWN).visible = false
				pass
			elif game_scene.hotel.elevator.position.y < -310:
				game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.UP).visible = false
				game_scene.hotel.elevator.get_tutorial_button(Globals.TUTORIAL_BUTTON.DOWN).visible = true
				pass
			if game_scene.hotel.elevator.position.y <= -210 && game_scene.hotel.elevator.position.y >= -310 && !game_scene.hotel.elevator.is_moving:
				perform_tutorial(2)
		2: 
			if Input.is_action_just_pressed("elevator_door_right"):
				Game.state.game_scene.hotel.floors[2].door_mechanism.open_right = true
				perform_tutorial(3)
		4:  if game_scene.hotel.elevator.position.y > -5.2 :
				perform_tutorial(5)
	pass
