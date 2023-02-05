extends Enemy

onready var life_bar = $Control/ProgressBar
onready var moeda = preload("res://element.tscn")

export var drop_moeda : int
var imoeda
var rushing = false
var rush_frame
var attacking = false
var start
func rush():
		#Parar
		speed = 0
		#Esperar 0.5s
		yield(get_tree().create_timer(0.7), "timeout")
		#Avançar em linha reta
		speed = (speed + maxspeed) * 2.5
		velocity = Vector2(speed,0).rotated(get_angle_to(
				player.position))
		move_and_slide(velocity, Vector2.UP)
		yield(get_tree().create_timer(0.5), "timeout")
		velocity = Vector2(0,0)
		attacking = false
		state = "active"
		move_and_slide(velocity, Vector2.UP)
func _ready():
	life = maxlife
	state = "active"
	life_bar.max_value = maxlife
	life_bar.value = life
	velocity = Vector2(0,0)
	player = get_tree().get_root().find_node("player", true, false)
func drop():
	for x in drop_moeda:
		imoeda = moeda.instance()
		imoeda.position = to_global(position)
		get_tree().get_root().add_child(imoeda)
func _physics_process(delta):
	if is_instance_valid(player):
		if position.distance_to(player.position) <= 250 and attacking == false:
			velocity = Vector2(0,0)
			state = "attack"
			attacking = true
			start = Engine.get_frames_drawn()
			rush()
	if state == "active":
		if is_instance_valid(player):
			chase()
		else:
			player = get_tree().get_root().find_node("player", true, false)
#
	move_and_slide(velocity, Vector2.UP)
	if life <= 0:
		drop()
		ded()

func _on_Area2D_area_entered(area):
	if area.is_in_group("player_dmg"):
		var hitter = area.get_parent()
		hit()
		life -= hitter.get("dmg")
		life_bar.value = life
		
