extends Enemy

onready var life_bar = $Control/ProgressBar
onready var moeda = preload("res://element.tscn")

export var drop_moeda : int

var velocity = Vector2()
var player
var imoeda
func _ready():
	player = get_tree().get_root().find_node("player", true, false)
	state = "active"
	life_bar.max_value = maxlife
	life_bar.value = life
	
func _physics_process(delta):
	if state == "active":
		velocity = Vector2(100,0).rotated(get_angle_to(
			player.position))
	move_and_slide(velocity, Vector2.UP)
	if life <= 0:
		
		print("tha skull is ded")
		for x in drop_moeda:
			imoeda = moeda.instance()
			get_tree().get_root().add_child(imoeda)
		queue_free()
func _on_Area2D_area_entered(area):
	if area.is_in_group("player_dmg"):
		var hitter = area.get_parent()
		hit(hitter.get("dmg"))
		life -= hitter.get("dmg")
		life_bar.value = life
		
