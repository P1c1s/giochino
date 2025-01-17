class_name Portale extends Area2D

@export var connected_scene: String
var scene_folder = "res://Scenes/Levels/" 

func _on_body_entered(_body: Node2D) -> void:
	var full_path = scene_folder + connected_scene + ".tscn"
	var scene_tree = get_tree()
	
	if _body is Adventurer:
		scene_tree.change_scene_to_file(full_path)
