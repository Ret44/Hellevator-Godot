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
		# add people saved
		# add money 
		
		
		pass
	'''if (!checkedOut)
	{
		BuenoGameData.Instance.peopleSaved++;
		BuenoGameData.Instance.AddMoney(value);

		// spawn money particles
		GameObject particle = Instantiate(value < 5 ? coinParticlePrefab : moneyParticlePrefab, transform.position, transform.rotation * Quaternion.Euler(0, 180, 0)) as GameObject;
		particle.transform.parent = DirectoryManagement.Instance.particles;
		float amount = value < 5 ? value * 1.5f : (value - 4) / 2;
		particle.GetComponent<ParticleSystem>().Emit(Mathf.CeilToInt(amount));
		Destroy(particle, 2f);

		HotelBuilding.instance.guests.Remove(this);
		UIManager.Instance.AddDude();
		UIManager.Instance.SetMoney();

		SoundPlayer.PlayCash();

		checkedOut = true;
	}
	// push out the guest
	float x = (HotelBuilding.instance.previousSinValue < 0) ? 1 : -1;
	rigidbody.AddForce(new Vector2(x * 25f, 0f), ForceMode2D.Impulse);
	'''
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if(position.y > 10):
	#	free()
	#	pass
	pass
