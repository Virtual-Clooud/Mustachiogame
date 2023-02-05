extends Weapon

export var bullet_speed : float  = 800
export var alt_bullet_speed : float = 700
export var alt_shots = 6
export var spread = 60

var rot
var tween = create_tween()

onready var default_shot = preload("res://default_shot.tscn")
onready var alt_shot = preload("res://alt_shot.tscn")
onready var muzzle = find_node("muzzle")
func _physics_process(delta):
	rot = get_angle_to(get_global_mouse_position())
	Engine.get_frames_drawn()
	
	if $Sprite.rotation_degrees <= -90 or $Sprite.rotation_degrees >= 90:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false
	match state:
		"idle":
			if Engine.get_frames_drawn() >= shot_frame+(
				cadency * Engine.get_frames_per_second()):
				can_shoot = true
			var tween = create_tween()
			tween.tween_property($Sprite, "position", 
			Vector2(20, 0).rotated(rot), 0.1)
			tween.tween_property(muzzle, "position", 
			Vector2(75, 0).rotated(rot), 0.1)
			tween.tween_property($Sprite, "rotation_degrees", 
			rad2deg(get_angle_to(
				get_global_mouse_position())), 0.01)
		"set":
			var tween = create_tween()
			tween.tween_property($Sprite, "position", 
			Vector2(50, 0).rotated(rot), 0.05)
			tween.tween_property(muzzle, "position", 
			Vector2(75, 0).rotated(rot), 0.05)
			tween.tween_property($Sprite, "rotation_degrees", 
			rad2deg(get_angle_to(
				get_global_mouse_position())), 0.01)
		"active":
			if can_shoot:
				simple_shot(default_shot, 
				get_angle_to(get_global_mouse_position()), 
				to_global(Vector2(65, 0).rotated(rot)),
				bullet_speed, dmg)
				can_shoot = false
				shot_frame = Engine.get_frames_drawn()
				$Sprite/CPUParticles2D.emitting = true
				$Sprite/CPUParticles2D2.emitting = true
			state = "idle"
		"alt_set":
			var tween = create_tween()
			tween.tween_property($Sprite, "position", 
			Vector2(50, 0).rotated(rot), 0.05)
			tween.tween_property(muzzle, "position", 
			Vector2(75, 0).rotated(rot), 0.05)
			tween.tween_property($Sprite, "rotation_degrees", 
			rad2deg(get_angle_to(
				get_global_mouse_position())), 0.01)
		"alt_active":
			if can_shoot:
				simple_mult_shot(alt_shot, 
				get_angle_to(get_global_mouse_position()), 
				to_global(Vector2(65, 0).rotated(rot)),
				alt_bullet_speed, alt_dmg, alt_shots, spread)
				shot_frame = Engine.get_frames_drawn()

				can_shoot = false
			state = "idle"
