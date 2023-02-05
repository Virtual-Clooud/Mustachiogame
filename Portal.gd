extends Sprite

onready var tween = create_tween()
export var next_level : Resource
func _physics_process(delta):
	if scale == Vector2(0.9,0.9):
		var atween = create_tween()
		atween.tween_property(self, "scale", Vector2(0.7,0.7), 0.5)
	elif scale == Vector2(0.7,0.7):
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2(0.9,0.9), 0.5)


func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		var ilevel = next_level.instance()
		get_tree().get_root().add_child(ilevel)
		self.get_parent().queue_free()
		
