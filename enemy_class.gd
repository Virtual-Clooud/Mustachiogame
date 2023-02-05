extends KinematicBody2D
class_name Enemy

export var maxlife : int
export var life : int
export var maxspeed = 100
export var target_time = 3.2
export var ded_sprite : Texture
export var target_icon : Texture = preload("res://target.png")
export var pain : int = 0
export var max_pain : int = 10 
var zero = 0
var velocity
var speed = 0
var player
var root
#target, bleed, etc
export var status : Array
####Idle, active, attack, etc##########
export var state : String

onready var status_icon = preload("res://status_icon.tscn")
#Conectar ao nível, quando spawnar dizer ao nível que estou vivo!
#Qnd morrer dizer que morreu
func _ready():
	player = get_tree().get_root().find_node("player", true, false)
	root = get_tree().get_root()
	self.connect("tree_entered", self.get_parent(), "enemy_spawn")
	self.connect("tree_exited", self.get_parent(), "enemy_died")
	emit_signal("tree_entered")

func ded():
	queue_free()
func target():
	zero += 1
	if zero >= target_time * Engine.get_frames_per_second():
		status.erase("target")
		zero = 0
	else:
		pass
func chase():
	speed = lerp(speed, maxspeed, 0.05)
	velocity = Vector2(speed,0).rotated(get_angle_to(
				player.position))
#Simple Hit animation
func hit():
	pain += 3
	var tween = create_tween()
	tween.tween_property($Sprite, "position", 
		Vector2(pain, -pain), 0.03)
	tween.parallel().tween_property($Sprite, "rotation_degrees", 
		90, 0.03)
	tween.tween_property($Sprite, "position", 
		Vector2(-pain, pain), 0.03)
	tween.tween_property($Sprite, "position", 
		Vector2(0, -pain), 0.03)
	tween.tween_property($Sprite, "position", 
		Vector2(pain, 0), 0.03)
	tween.parallel().tween_property($Sprite, "rotation_degrees", 
		-30, 0.1)
	tween.tween_property($Sprite, "position", 
		Vector2(0, 0), 0.03)
	tween.tween_property($Sprite, "rotation_degrees", 
		0, 0.03)
func _physics_process(delta):
	if is_instance_valid(player):
		pass
	else:
		player = get_tree().get_root().find_node("player", true, false)
	for x in status.size():
		if status[x] == "target":
			target()
			var icon = status_icon.instance()
			icon.set_texture(target_icon)
			icon.set("time", target_time)
			add_child(icon)
			
