extends KinematicBody2D
class_name Player

export var life = 10
export var maxlife = 10
export var speed : int = 100
var velocity = Vector2(0,0)

func move():
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	elif Input.is_action_pressed("right"):
		velocity.x = speed
	else:
		velocity.x = 0
		
	if Input.is_action_pressed("up"):
		velocity.y = -speed
	elif Input.is_action_pressed("down"):
		velocity.y = speed
	else:
		velocity.y = 0
func die():
	get_tree().get_root().queue_free()
func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP)
	if life == 0:
		die()
		
