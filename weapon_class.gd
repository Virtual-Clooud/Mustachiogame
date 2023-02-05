extends Node2D
class_name Weapon

# Control Setup
# Stats
export var cadency : float = 0.1
export var dmg : float = 1
export var alt_dmg : float = 5
# Weapon State
var state = "idle"
var shot_frame = Engine.get_frames_drawn()
var can_shoot = true
# Get variables from player
var player
func simple_shot(bullet, brotation, bposition, bspeed, bdmg):
	var ibullet = bullet.instance()
	ibullet.rotation_degrees = rad2deg(brotation)
	ibullet.position = bposition
	ibullet.set("speed", bspeed)
	ibullet.set("dmg", bdmg)
	get_tree().get_root().add_child(ibullet)

func simple_mult_shot(
	bullet, brotation, bposition, bspeed, bdmg, xshots, spread):
	#Fazer tiros separados tipo o especial do arco em Hades
	var iangle = spread
	for x in xshots:
		
		var ibullet = bullet.instance()
		ibullet.rotation_degrees = rad2deg(brotation) + iangle
		ibullet.position = bposition
		ibullet.set("speed", bspeed)
		ibullet.set("dmg", bdmg)
		get_tree().get_root().add_child(ibullet)
		iangle = iangle - (spread + spread)/(xshots)
		yield(get_tree().create_timer(0.02), "timeout")
func _ready():
	player = get_tree().get_root().find_node("player", true, false)

func _physics_process(delta):
	if Input.is_action_pressed("primaria"):
		state = "set"
	elif Input.is_action_just_released("primaria"):
		state = "active"
	elif Input.is_action_pressed("secundaria"):
		state = "alt_set"
	elif Input.is_action_just_released("secundaria"):
		state = "alt_active"
			# Update variables from player
	if state == "idle":
		if Engine.get_frames_drawn() >= shot_frame+(
			cadency * Engine.get_frames_per_second()):
				can_shoot = true
