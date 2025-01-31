class_name MobileControls extends CanvasLayer

var scene_to_load = preload("res://Scenes/Menus/Pause.tscn")

func _on_pause_pressed() -> void:
	var scene = scene_to_load.instantiate()
	add_sibling(scene)
	self.queue_free()
