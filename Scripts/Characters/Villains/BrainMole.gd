class_name BrainMole extends CharacterBody2D

@export var speed = 40
@export var limit = 0.5
@export var attackLimit = 60

@onready var state_machine = $AnimationTree["parameters/playback"]

var startPosition
var endPosition
@onready var player_chase: bool = false

var target: CharacterBody2D

#flag variable to check whether the attack animation is playing or not
var attackMode : bool

#flag used to check whether the enemey collided with the player or not
var collisionPlayer : bool

#variable for the life progress bar
var life: int

var numAttacks

func _ready():
	startPosition = position
	endPosition = position
	state_machine.travel("Idle")
	attackMode = false
	life = 100
	collisionPlayer = false
	numAttacks = 0
	$Movimento.start()
	
func _physics_process(_delta):
	#if the player isn't near the cyclop, the enemy moves with his default dynamic
	if not player_chase:
		stand()
	elif player_chase:
		chase()
	move_and_slide()
	
	$BrainMoleLife.value = life
	
	if (life == 0):
		state_machine.travel("Die")

func stand():
	state_machine.travel("Idle")

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

func attack():
	attackMode = true
	state_machine.travel("Attack")
	
	if collisionPlayer and numAttacks == 0:
		GameManager.getDamage()

func _on_movimento_timeout() -> void:
	$Sprite2D.flip_h = !$Sprite2D.flip_h
	$Movimento.start()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack":
		collisionPlayer = false
		#print("ANIMAZIONE ATTACCO FINITA")
		if $Cooldown.is_stopped():
			$Cooldown.start()
		var distanza = endPosition - position
		if distanza.length() < attackLimit:
			state_machine.call_deferred("travel", "Idle")
		else:
			state_machine.call_deferred("travel", "Walk")
			velocity = distanza.normalized() * speed
	
	if anim_name == "Die":
		self.queue_free()


func _on_detection_area_body_entered(body: Node2D) -> void:
	#print(body is Adventurer)
	if body is Adventurer:
		target = body
		player_chase = true
	if not $Movimento.is_stopped():
		$Movimento.stop()

func _on_cooldown_timeout() -> void:
	#print("COOLDOWN ENDED ATTACK AGAIN")
	numAttacks = 0;
	attack()


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is Adventurer:
		player_chase = false
		attackMode = false
		startPosition = position
		endPosition = position
		state_machine.travel("Walk")
		if not $Cooldown.is_stopped():
			$Cooldown.stop()

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is Adventurer:
		collisionPlayer = true;
