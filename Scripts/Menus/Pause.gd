class_name Scene extends CanvasLayer

var scene_to_load = load("res://Scenes/UI/MobileControls.tscn")
var scene

func _ready():
	scene = scene_to_load.instantiate()

func _on_resume_pressed() -> void:
	#var scene = scene_to_load.instantiate()
	GameManager.iconClick()
	self.get_parent().add_child(scene)
	self.queue_free()


func _on_levels_pressed() -> void:
	GameManager.iconClick()
	if self.get_parent().name == "Level1":
		get_tree().change_scene_to_file("res://Scenes/Menus/WorldOneLocked.tscn")
	elif self.get_parent().name == "Level2":
		get_tree().change_scene_to_file("res://Scenes/Menus/WorldTwo.tscn")
	
	#questa non funziona
	elif self.get_parent().name == "Level3":
		get_tree().change_scene_to_file("res://Scenes/Menus/WorldThree.tscn")
