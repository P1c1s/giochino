class_name Adventurer extends CharacterBody2D

#const SPEED =300.0
const JUMP_VELOCITY = -300.0

var run_speed = 180.0
var attackMode = false
var collisionEnemy = false
var enemy : CharacterBody2D
var attackNumbers : int = 0

# attack sounds
@onready var state_machine = $AnimationTree["parameters/playback"]

func _ready() -> void:
	GameManager.restoreLife()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	var _current_anim = state_machine.get_current_node()
	
	#gravita se non è a terra
	if not is_on_floor():
		velocity += get_gravity() * delta
	#gestisce la fisica del salto
	else:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			print("SALTO")		#stampa di prova
			velocity.y = JUMP_VELOCITY
			move_and_slide()
			state_machine.travel("Jump")
			return
	
	#gestisce il movimento a destra e sininstra
	velocity.x = Input.get_axis("ui_left", "ui_right") * run_speed
	if Input.is_action_just_pressed("ui_attack"):
		$AreaAttacco/CollisionShape2D.disabled = false
		attackMode = true
		if velocity.x:
			state_machine.travel("AttackRun")
		else:
			state_machine.travel("Attack")
		return
	
	
	########PERCHE' NUMERO DI ATTACCO
	if attackMode and collisionEnemy and attackNumbers == 0:
		GameManager.giveDamage(enemy)
		attackNumbers += 1
	
	if !attackMode:
		$AreaAttacco/CollisionShape2D.disabled = true
	
	if velocity.x != 0:
		$Sprite2D.scale.x = sign(velocity.x)				#flip_h
		$AreaAttacco/CollisionShape2D.scale.x = sign(velocity.x)
		$AreaAttacco/CollisionShape2D.position.x = sign(velocity.x)
	if velocity.length() > 0:
		state_machine.travel("Run")
	else:
		state_machine.travel("Idle")
	move_and_slide()


func _on_area_attacco_body_entered(body: Node2D) -> void:
	if body is Cocodaemon:				#poi inserire anche gli altri nemici
		collisionEnemy = true
		enemy = body

func _on_area_attacco_body_exited(body: Node2D) -> void:
	if body is Cocodaemon:
		collisionEnemy = false

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack" or anim_name == "AttackRun":
		attackMode = false
		attackNumbers = 0
