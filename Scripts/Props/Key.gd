class_name Key extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Adventurer: 
		GameManager.setKeyCollected()
		self.queue_free()
