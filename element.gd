extends RigidBody2D


var player
var chase_player = false

export var tipo : String
export var qtd = 1
export var valor = 1
export var icone : Texture = preload("res://icon.png")
func _physics_process(delta):
	if chase_player:
		linear_velocity = lerp(linear_velocity, Vector2(100,0).rotated(get_angle_to(
			player.position)), 0.5)
func _ready():
	randomize()
	player = get_tree().get_root().find_node("player", true, false)
	player.find_node("collect_area")
func _on_detect_area_entered(area):
	if area.is_in_group("player"):
		chase_player = true
func _on_collect_area_entered(area):
	if area.is_in_group("player"):
		var inventory = player.get("inventory")
		if inventory.has(tipo):
			inventory[tipo][0] += qtd
		else:
			inventory[tipo] = [qtd]
		match tipo:
			"bota pika":
				player.set("speed", (player.get("speed") + valor)) 
			
		queue_free()
	
