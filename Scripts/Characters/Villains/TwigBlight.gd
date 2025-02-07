class_name TwigBlight extends CharacterBody2D

@export var speed = 80
@export var attackLimit = 250

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

var numDamage: int

func _ready():
	startPosition = position
	endPosition = position
	state_machine.travel("Idle")
	attackMode = false
	life = 500
	collisionPlayer = false
	$Movimento.start()
	numDamage = 0;

		
func _physics_process(_delta):
	if not player_chase && not collisionPlayer:
		stand()
	elif player_chase:
		chase()
	move_and_slide()
	
	$TwigBlightLife.value = life
	
	if GameManager.checkLife() <= 0:
		player_chase = false

func stand():
	state_machine.travel("Idle")

func chase():
	var direzione = endPosition - position
	$Sprite2D.flip_h = (direzione.x < 1)
	endPosition = target.position
	var dist = endPosition - position
	velocity.x = dist.normalized().x * speed
	state_machine.travel("Walk")
	
	if collisionPlayer && dist.x < 100:
		state_machine.travel("Die")

func _on_movimento_timeout() -> void:
	$Sprite2D.flip_h = !$Sprite2D.flip_h
	$Movimento.start()

#func attack():
	#attackMode = true
	#state_machine.travel("Die")
	#if collisionPlayer and numAttacks == 0:

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Die":
		GameManager.getDamage()
		player_chase = false
		self.queue_free()
		
		#---SCHERMATA GAME OVER ---   da gestire o nell'Adventurer o inserire script
		#livelli per gestione game over e you made it. 


func _on_detection_area_body_entered(body: Node2D) -> void:
	#print(body is Adventurer)
	if body is Adventurer:
		target = body
		player_chase = true

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is Adventurer:
		#player_chase = false
		print("Adv entrato in hitbox")
		collisionPlayer = true;
		#state_machine.travel("Attack")
