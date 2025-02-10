class_name BrainMole extends CharacterBody2D

@export var speed = 40
@export var attackLimit = 60

@onready var state_machine = $AnimationTree["parameters/playback"]

var startPosition
var endPosition
@onready var player_chase: bool = false

var target: CharacterBody2D

var attackMode: bool
var collisionPlayer: bool
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

func _physics_process(_delta):
	if not player_chase:
		stand()
	else:
		chase()
	move_and_slide()

	$BrainMoleLife.value = life

	if life <= 0:
		state_machine.travel("Die")

func stand():
	velocity = Vector2.ZERO
	state_machine.travel("Idle")

func chase():
	var direction = (target.position - position)
	velocity = direction.normalized() * speed
	$Sprite2D.flip_h = (direction.x < 0)
	state_machine.travel("Walk")

	if direction.length() < attackLimit:
		attack()

func attack():
	if not attackMode:
		attackMode = true
		state_machine.travel("Attack")
		if collisionPlayer and numAttacks == 0:
			GameManager.getLessDamage()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack":
		attackMode = false
		if $Cooldown.is_stopped():
			$Cooldown.start()
		state_machine.travel("Idle")

	if anim_name == "Die":
		self.queue_free()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Adventurer:
		target = body
		player_chase = true

func _on_cooldown_timeout() -> void:
	numAttacks = 0
	attack()

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is Adventurer:
		player_chase = false
		attackMode = false
		velocity = Vector2.ZERO
		state_machine.travel("Walk")

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is Adventurer:
		collisionPlayer = true
