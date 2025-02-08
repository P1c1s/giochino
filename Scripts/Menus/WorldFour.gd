class_name WorldFour extends CanvasLayer

func _on_home_pressed() -> void:
	GameManager.iconClick()
	get_tree().change_scene_to_file("res://Scenes/Menus/Home.tscn")

func _on_prec_pressed() -> void:
	GameManager.iconClick()
	get_tree().change_scene_to_file("res://Scenes/Menus/WorldThree.tscn")

func _on_settings_pressed() -> void:
	GameManager.iconClick()
	get_tree().change_scene_to_file("res://Scenes/Menus/Settings.tscn")
