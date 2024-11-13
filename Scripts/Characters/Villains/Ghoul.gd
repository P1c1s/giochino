extends CharacterBody2D

@export var speed = 40
@export var limit = 0.5

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = startPosition - Vector2(-50, 0)

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		changeDirection()
		$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
		
	velocity = moveDirection.normalized()*speed

func _physics_process(_delta):
	updateVelocity()
	move_and_slide()
