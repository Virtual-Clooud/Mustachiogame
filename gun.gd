extends Weapon

export var cadency : float = 0.1
export var bullet_speed : float  = 800
export var alt_bullet_speed : float = 700
export var alt_shots = 6

var rot
var can_shoot = true
var tween = create_tween()
var shot_frame = 0

onready var default_shot = preload("res://default_shot.tscn")
onready var muzzle = get_node("muzzle")
func default_shot():
	var bullet = default_shot.instance()
	bullet.rotation_degrees = rad2deg(get_angle_to(
		get_global_mouse_position()))
	bullet.position = to_global(Vector2(65, 0).rotated(rot))
	bullet.set("speed", bullet_speed)
	bullet.set("dmg", dmg)
	get_tree().get_root().add_child(bullet)
func alt_shot(alt_shots):
	#Fazer tiros separados tipo o especial do arco em Hades
	var Pangle = 60
	var iangle = Pangle
	for x in alt_shots:
		$Sprite/CPUParticles2D.emitting = true
		$Sprite/CPUParticles2D2.emitting = true
		var bullet = default_shot.instance()
		bullet.rotation_degrees = rad2deg(get_angle_to(
			get_global_mouse_position())) + iangle
		bullet.position = to_global(Vector2(65, 0).rotated(rot))
		bullet.set("speed", bullet_speed*1.8)
		bullet.set("dmg", dmg/2)
		get_tree().get_root().add_child(bullet)
		iangle = iangle - (Pangle + Pangle)/(alt_shots - 1)

func _physics_process(delta):
	Engine.get_frames_drawn()
	rot = get_angle_to(get_global_mouse_position())
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
			Vector2(40, 0).rotated(rot), 0.1)
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
				default_shot()
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
				alt_shot(alt_shots)
				shot_frame = Engine.get_frames_drawn()

				can_shoot = false
			state = "idle"
		"guard":
			pass
