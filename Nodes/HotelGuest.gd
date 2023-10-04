class_name HotelGuest
extends RigidBody2D

@export var money_particle_path : String
var money_particle_prefab
@export var coin_particle_path : String
var coin_particle_prefab

var mass_limit : Vector2
var value : float
var min_value : int = 3
var max_value : int = 5
var checked_out : bool

@export_node_path var animator_path : NodePath
var animator : AnimatedSprite2D

@export var checkout_timer : float = 10

func _init():
	money_particle_prefab = load(money_particle_path)
	coin_particle_prefab = load(coin_particle_path)
	animator = get_node(animator_path)
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready():
	mass_limit = Vector2(1,3)
	animator = get_node(animator_path)
	pass # Replace with function body.


func randomize_mass():
	mass = randf_range(mass_limit.x, mass_limit.y)
	pass

func randomize_value(floor):
	value = ceil(randi_range(min_value, max_value+1) / 2 * floor)
	pass

func drop(): 
	if(!checked_out):
		Game.state.add_dude()
		Game.state.add_money(value)
		var particles_prefab
		var amount
		if(value < 5):
			particles_prefab = Game.state.coin_particle_prefab
			amount = value * 1.5
		else:
			particles_prefab = Game.state.money_particle_prefab
			amount = value - 4 / 2
			pass		
		var particles = particles_prefab.instantiate()
		particles.position = position
		get_parent().add_child(particles)
		particles.name = name + "Particles"
		#particles.emit(amount)
		var kick_direction : float = 0
		if(Game.state.game_scene.hotel.previous_sin_value < 0):
			kick_direction = -1 
		else:
			kick_direction = 1
			pass
		apply_impulse(Vector2(1000 * kick_direction, 0))
		Sounds.play(Sounds.cash)
		Game.state.game_scene.hotel.guests.erase(self)
		checked_out = true
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(checked_out):
		checkout_timer -= delta
		if(checkout_timer <= 0):
			queue_free()
			pass
		pass
	pass
