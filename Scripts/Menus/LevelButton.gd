class_name LevelButton extends TouchScreenButton

@export var connected_scene: String
var scene_folder = "res://Scenes/Levels/"

func _on_pressed() -> void:
	print("ciao")
	var full_path = scene_folder + connected_scene + ".tscn"
	var scene_tree = get_tree()
	scene_tree.change_scene_to_file(full_path)
