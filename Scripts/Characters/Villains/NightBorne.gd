class_name NightBorne extends CharacterBody2D

@export var speed = 60
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

var numAttacks

func _ready():
	startPosition = position
	endPosition = position
	state_machine.travel("Idle")
	attackMode = false
	life = 500
	collisionPlayer = false
	numAttacks = 0
		
func _physics_process(_delta):
	if not player_chase:
		stand()
	elif player_chase:
		chase()
	move_and_slide()
	
	$NightBorneLife.value = life
	
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

#func attack():
	#attackMode = true
	#state_machine.travel("Death")
	#if collisionPlayer and numAttacks == 0:

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		GameManager.deathAttack()
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
		print("Adv entrato in hitbox")
		collisionPlayer = true;
		state_machine.travel("Death")
