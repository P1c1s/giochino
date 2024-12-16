class_name IconCoin extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#var coin = get_node("res://Scenes/Levels/Livello1.tscn")
	#coin.connect(coin.coin_collected, on_coin_collected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func on_coin_collected():
	var value = int($Label.text) + 1
	$Label.text = String(value)
