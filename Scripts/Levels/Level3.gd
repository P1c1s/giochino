class_name Level3 extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Environment.play()
	GameManager.score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
