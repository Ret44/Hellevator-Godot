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

# Called when the node enters the scene tree for the first time.
func _ready():
	coin_particle_prefab = load(coin_particle_path)
	money_particle_prefab = load(money_particle_path)
	pass # Replace with function body.

func process_state_enter(args):
	super(args)
	game_scene = load(game_scene_path).instantiate()
	get_tree().root.get_node("GameRoot").add_child(game_scene)
	game_scene._ready()
	timer = round_time
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
	game_scene.camera.shake(2.5)
	UIManager.show_hud(false)
	game_scene.hotel.set_lobby_broken(true)
	pass

func process_input(delta):
	
	pass

func process_state(delta):
	if(timer > 0):
		timer -= delta
		if(timer <= 0):
			timer = 0
			pass
		UIManager.set_time(timer)
		pass
	pass
