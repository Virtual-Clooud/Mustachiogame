extends Node2D
class_name Weapon

# Control Setup
# Stats
export var dmg = 1
export var alt_dmg = 1
# Weapon State
var state = "idle"
# Get variables from player
var player
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
	if state == "set":
		pass
