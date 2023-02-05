extends Bullet
onready var tween = create_tween()
var target_pos
var target = null
var is_tracking = false
func _physics_process(delta):
	if is_tracking:
		life_time += 2
	if is_instance_valid(target):
		velocity = Vector2(speed*0.4, 
			speed*0.4) * position.direction_to(
			target.position)
	else:
		velocity = Vector2(speed,0).rotated(rotation)
	rotation = velocity.angle()
		
	move_and_slide(velocity, Vector2.UP)
func _on_target_area_area_entered(area):
	if area.is_in_group("enemy"):
		if is_tracking == false:
			if area.get_parent().get("status").has("target"):
				target = area.get_parent()
				is_tracking = true
func _on_hit_area_area_entered(area):
	if area.is_in_group("enemy"):
		for x in status.size():
			if area.get_parent().get("status").has(status[x]):
				pass
			else:
				area.get_parent().get("status").append(status[x])
		queue_free()


