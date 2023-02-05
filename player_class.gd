extends KinematicBody2D
class_name Player

export var life = 10
export var maxlife = 10
export var speed : int = 100
var velocity = Vector2(0,0)

func move():
	if Input.is_action_pressed("left"):
		velocity.x = lerp(velocity.x, -speed, 0.2)
	elif Input.is_action_pressed("right"):
		velocity.x = lerp(velocity.x, speed, 0.2)
	else:
		velocity.x = lerp(velocity.x, 0, 0.2)
		
	if Input.is_action_pressed("up"):
		velocity.y = lerp(velocity.y, -speed, 0.2)
	elif Input.is_action_pressed("down"):
		velocity.y = lerp(velocity.y, speed, 0.2)
	else:
		velocity.y = lerp(velocity.y, 0, 0.2)
func die():
	get_tree().get_root().queue_free()
func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP)
	if life == 0:
		die()
		
