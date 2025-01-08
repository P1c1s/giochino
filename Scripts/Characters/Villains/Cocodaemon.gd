class_name Cocodaemon extends CharacterBody2D

@export var speed = 40
@export var chase_speed = 80
@export var limit = 0.5

@onready var state_machine = $AnimationTree["parameters/playback"]

#var gravita = 140.00

var startPosition
var endPosition

var life : int

var player_chase = false
var player : CharacterBody2D

@onready var timer = $Timer
var cooldown = false

func _ready():
	life = 100
	startPosition = position
	endPosition = startPosition - Vector2(50, 0)
	#$Sprite2D.flip_h = true

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized()*speed
	$Sprite2D.flip_h = sign(velocity.x)

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	if player_chase:
		if abs(player.position.x - position.x) > limit:
			position.x += (player.position.x - position.x)/chase_speed
			#$Sprite2D.flip_h = sign(velocity.x)
			#state_machine.travel("Walk")
	else:
		updateVelocity()
	
	$Sprite2D.flip_h = sign(velocity.x)
	
	$CocodaemonLife.value = life
	
	if life == 0:
		state_machine.travel("Die")
		if $AnimationPlayer.animation_finished("Die"):
			self.queue_free()


func _on_timer_timeout() -> void:
	cooldown = false

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Adventurer:
		player_chase = true
		player = body

func _on_detection_area_body_exited(_body: Node2D) -> void:
	player_chase = false



#CHARACTER BEHAVIOUR
#First: autoplay animation walk. Limited movement between two coordinates
		#when endPosition reached, exchange startPosition and endPosition, flip sprite
#When detect player: chase him and attack
		#detect player with area2d, set adventurer position as endPosition
		#attack every x seconds, where x is the cooldown time
#If he gets damage and his life is 0: he dies
		#AnimationPlayer play die animation, when finished it gets removed from node tree
