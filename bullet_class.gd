extends KinematicBody2D
class_name Bullet

export var dmg : int = 5
export var life_time = 0.7
var born_frame
func _ready():
	born_frame = Engine.get_frames_drawn()
func _physics_process(delta):
	if Engine.get_frames_drawn() >= born_frame+(
		life_time * Engine.get_frames_per_second()):
		queue_free()
