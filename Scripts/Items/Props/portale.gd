class_name portale extends Area2D

@export var connected_scene: String
var scene_folder = "res://Scenes/Levels/" 

func _on_body_entered(body: Node2D) -> void:
	var full_path = scene_folder + connected_scene + ".tscn"
	var scene_tree = get_tree()#che minchia è scene_tree??
	scene_tree.change_scene_to_file(full_path)
