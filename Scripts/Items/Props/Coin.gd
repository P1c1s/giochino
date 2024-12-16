class_name Coin extends Node

signal coin_collected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_body_entered(body: Node2D) -> void:
	if (body is Adventurer) or (body is Fox):
		coin_collected.emit()
		print("MONETA")
		self.queue_free()
