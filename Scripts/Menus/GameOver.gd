extends CanvasLayer

func _ready() -> void:
	$Sfx.play()

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/Home.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/Settings.tscn")
	
func _on_levels_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/WorldOneLocked.tscn")
