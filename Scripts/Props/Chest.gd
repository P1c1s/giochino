class_name Chest extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Adventurer and GameManager.isKeyCollected():
		$AnimatedSprite2D.play("default")
		GameManager.initKeyCollected()
