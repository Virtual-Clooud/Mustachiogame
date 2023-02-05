extends Bullet
onready var tween = create_tween()
export var bounced = false
func _ready():
	status = ["target"]
	$CollisionShape2D.set_disabled(true)
	velocity = Vector2(speed,0).rotated(rotation)
	tween.tween_property($hit_area/CollisionShape2D, "disabled", 
	false, 0.1)
	
func _physics_process(delta):
#	if bounced == true:
#		dmg = dmg +(dmg *0.2)
	if Engine.get_frames_drawn() >= born_frame + 2:
		$CollisionShape2D.set_disabled(false)
	move_and_slide(velocity, Vector2.UP)
	#Sistema de ricochete
	if is_on_wall() or is_on_floor() or is_on_ceiling():
		life_time -= 0.7
		$Sprite.modulate = Color(1, 0.047059, 0)
		bounced = true
	if is_on_wall():
		if velocity.x >= 0:
			position.x -= 15
		else:
			position.x += 15
		velocity = (Vector2(speed,0).rotated(rotation*rand_range(
			1,1)).bounce(Vector2(1,0))) * Vector2(1.5,1.5)

	elif is_on_floor():
		position.y -= 15
		velocity = (Vector2(speed,0).rotated(rotation*rand_range(
			1,1)).bounce(Vector2(0,1)))* Vector2(1.5,1.5)

	elif is_on_ceiling():
		position.y += 15
		velocity = (Vector2(speed,0).rotated(rotation*rand_range(
			1,1)).bounce(Vector2(0,-1))) * Vector2(1.5,1.5)
	rotation = lerp(rotation, velocity.angle(), 0.2)
func _on_hit_area_area_entered(area):
	if area.is_in_group("enemy"):
		if bounced == true:
			for x in status.size():
				if area.get_parent().get("status").has(status[x]):
					pass
				else:
					area.get_parent().get("status").append(status[x])
		queue_free()
