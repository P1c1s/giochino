class_name Home extends CanvasLayer

func _on_play_pressed() -> void:
	GameManager.iconClick()
	get_tree().change_scene_to_file("res://Scenes/Menus/WorldOneLocked.tscn")
