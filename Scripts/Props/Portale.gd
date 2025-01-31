class_name Portale extends Area2D

var scene_to_load = load("res://Scenes/Menus/Win.tscn")

func _on_body_entered(_body: Node2D) -> void:	
	if _body is Adventurer:
		
		var scene = scene_to_load.instantiate()
		self.get_parent().add_child(scene)
