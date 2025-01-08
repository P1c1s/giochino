class_name Ghoul extends CharacterBody2D

@export var speed = 40
@export var limit = 0.5
@export var attackLimit = 60

@onready var state_machine = $AnimationTree["parameters/playback"]

var startPosition
var endPosition
@onready var player_chase: bool = false

var target: CharacterBody2D

#variabile flag per capire quando è in riproduzione l'animazione dell'attacco
var attackMode

func _ready():
	startPosition = position
	endPosition = startPosition - Vector2(-120, 0)
	state_machine.travel("Walk")
	attackMode = false

func _physics_process(_delta):
	#if the player isn't near the ghoul, the enemy moves with his default dynamic
	if not player_chase:
		move()
	elif player_chase:
		chase()
	move_and_slide()

#swaps the coordinates of A and B and flips the sprite
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	#$Sprite2D.flip_h = !$Sprite2D.flip_h

#if the ghoul doesn't chase the player, he moves back and forth between two points A and B
#when he gets to A and B he stops there for 4 seconds in the Idle state
func move() -> void:
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		if $Movimento.is_stopped():
			$Movimento.start()
		state_machine.travel("Idle")
	velocity = moveDirection.normalized() * speed
	$Sprite2D.flip_h = (moveDirection.x < -0.05)

#if the ghoul is chasing the player, the player's position is set to be the endPosition
#if the distance betweem the player and the ghoul is under a limit, he starts to attack
func chase():
	var direzione = endPosition - position
	$Sprite2D.flip_h = (direzione.x < 1)
	if not attackMode:
		endPosition = target.position
		var dist = endPosition - position
		#$Sprite2D.flip_h = (dist.x < 1)
		velocity = dist.normalized() * speed
		state_machine.travel("Walk")
		if dist.length() < attackLimit:
			attack()


#during the attack is played the attack animation and the cooldown timer is started
func attack():
	attackMode = true
	print("ATTACK")
	state_machine.travel("Attack")
	
		#cooldown()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack":
		print("ANIMAZIONE ATTACCO FINITA")
		if $Cooldown.is_stopped():
			$Cooldown.start()
		var distanza = endPosition - position
		if distanza.length() < attackLimit:
			state_machine.call_deferred("travel", "Idle")
		else:
			state_machine.call_deferred("travel", "Walk")
			velocity = distanza.normalized() * speed


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Adventurer:
		target = body
		player_chase = true
	if not $Movimento.is_stopped():
		$Movimento.stop()


func _on_movimento_timeout() -> void:
	print("TIMER SCADUTO CAMBIO DIREZIONE")
	state_machine.travel("Walk")
	changeDirection()

#at the end of the cooldown the ghoul attaks again
func _on_cooldown_timeout() -> void:
	print("COOLDOWN ENDED ATTACK AGAIN")
	attack()


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is Adventurer:
		player_chase = false
		attackMode = false
		startPosition = position
		endPosition = startPosition - Vector2(-120, 0)
		state_machine.travel("Walk")
		if not $Cooldown.is_stopped():
			$Cooldown.stop()


#METTERE ON ANIMATION FINISHED ATTACK --> attackmode = false e far partire il cooldown




#CHARACTER BEHAVIOUR:
	#First: autoplay animation. Walk to right for x seconds, then idle for x seconds
	#		then walk to the left for x seconds
	#When Adventurer detected: chase player and attacks every y seconds, where y is
	#		the cooldown time
	#When gets damage and life is zero: he dies
	#		animationPlayer plays dying animation, and then he removes himself from
	#		node tree
