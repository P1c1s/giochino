class_name WorldOne extends CanvasLayer

func _on_next_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/WorldTwo.tscn")

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/Home.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/Settings.tscn")

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")
