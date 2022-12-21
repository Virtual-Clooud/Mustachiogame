extends Player
#Fazer um sistema de inventário global
# Ites seguem: nome, tipo, cena, atributos extras
export var inventory = {
	"revolvi": ["revolvi", "arma", "res://gun.tscn"],
	"moeda": [0],
	"ultimate": [0],
}
export var min_ult = 0 
func _physics_process(delta):
	move()
	if Input.is_action_just_pressed("ultimate") and inventory["ultimate"][0] >= min_ult:
		print("IM ULTING")
	
