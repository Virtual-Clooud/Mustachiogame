extends Node2D
class_name Level

export var nWaves : int = 2
export var minenemies : int = 1
export var next_level : Resource
onready var portal = preload("res://portal.tscn")
onready var current_enemies : int
var portal_spawned = false
var frame_born
func spawn_next_wave():
	pass
func spawn_portal(Pposition):
	var ip = portal.instance()
	ip.position = Pposition
	var nl = next_level
	ip.set("next_level", nl)
	add_child(ip)
func _ready():
	frame_born = Engine.get_frames_drawn()
func _physics_process(delta):
	if current_enemies == minenemies and Engine.get_frames_drawn() > frame_born + 50 and portal_spawned == false:
		spawn_portal($Pposition.position)
		portal_spawned = true
func enemy_spawn():
	current_enemies += 1
func enemy_died():
	current_enemies -= 1
