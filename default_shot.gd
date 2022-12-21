extends Bullet
onready var tween = create_tween()
onready var velocity = Vector2()
export var speed = 800
var first_frame
func _ready():
	first_frame = Engine.get_frames_drawn()
	$CollisionShape2D.set_disabled(true)
	velocity = Vector2(speed,0).rotated(rotation)
	tween.tween_property($hit_area/CollisionShape2D, "disabled", 
	false, 0.1)
	
func _physics_process(delta):
	if Engine.get_frames_drawn() >= first_frame + 2:
		$CollisionShape2D.set_disabled(false)
	move_and_slide(velocity, Vector2.UP)
	
#	if is_on_floor() or is_on_wall() or is_on_ceiling():
#		velocity = Vector2(speed,0).rotated(rotation).reflect(Vector2.UP)



func _on_hit_area_area_entered(area):
	if area.is_in_group("enemy"):
		queue_free()
