extends Enemy

onready var life_bar = $Control/ProgressBar
func _ready():
	maxlife = 100
	life = 90
	life_bar.max_value = maxlife
	life_bar.value = life
	
func _physics_process(delta):
	if life <= 0:
		print("tha dummy is ded")
func _on_Area2D_area_entered(area):
	if area.is_in_group("player_dmg"):
		var hitter = area.get_parent()
		hit(hitter.get("dmg"))
		life -= hitter.get("dmg")
		life_bar.value = life
		
