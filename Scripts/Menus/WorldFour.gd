class_name WorldFour extends CanvasLayer

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/Home.tscn")

func _on_prec_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/WorldThree.tscn")
