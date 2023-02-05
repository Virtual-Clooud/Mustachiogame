extends TextureButton

onready var scene = preload("res://demo1.tscn")
onready var tween = create_tween()



func _on_play_pressed():
	var iscene = scene.instance()
	get_tree().get_root().add_child(iscene)
	print("Im pressed")
	self.get_parent().get_parent().queue_free()


func _on_play_mouse_entered():
	pass


func _on_play_mouse_exited():
	pass
