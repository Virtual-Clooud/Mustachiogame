extends KinematicBody2D
class_name Enemy

export var maxlife : int
export var life : int
export var pain = 20
export var status : String
#Idle, active, attack, etc
export var state : String
func ded():
	print("IM DED M8")
#Simple Hit animation
func hit(intensity):
	var tween = create_tween()
	var modified_pain = pain + (pain * intensity/50)
	tween.tween_property($Sprite, "position", 
		Vector2(modified_pain, -modified_pain), 0.03)
	tween.parallel().tween_property($Sprite, "rotation_degrees", 
		90, 0.03)
	tween.tween_property($Sprite, "position", 
		Vector2(-modified_pain, modified_pain), 0.03)
	tween.tween_property($Sprite, "position", 
		Vector2(0, -modified_pain), 0.03)
	tween.tween_property($Sprite, "position", 
		Vector2(modified_pain, 0), 0.03)
	tween.parallel().tween_property($Sprite, "rotation_degrees", 
		-30, 0.1)
	tween.tween_property($Sprite, "position", 
		Vector2(0, 0), 0.03)
	tween.tween_property($Sprite, "rotation_degrees", 
		0, 0.03)
func _physics_process(delta):
	match status:
		"gun":
			print("im gun target")
		_:
			pass
