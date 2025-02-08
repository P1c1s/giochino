class_name Key extends Area2D

var key = load("res://Assets/Music/Coin.mp3")
var audio_player = AudioStreamPlayer.new()

func _on_body_entered(body: Node2D) -> void:
	if body is Adventurer: 
		GameManager.setKeyCollected()
		GameManager.addKeyScore()
		self.queue_free()
