class_name LifeBar_CoinNumber extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = "%d" %0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Label.text = "%d" % GameManager.score
	$LifeIndicator.value = GameManager.adventurerLife
