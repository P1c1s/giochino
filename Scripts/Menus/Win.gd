class_name Win extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_levels_pressed() -> void:
	if get_parent().name == "Level1":
			get_tree().change_scene_to_file("res://Scenes/Menus/WorldOne.tscn")
	elif get_parent().name == "Level2":
			get_tree().change_scene_to_file("res://Scenes/Menus/WorldTwo.tscn")
