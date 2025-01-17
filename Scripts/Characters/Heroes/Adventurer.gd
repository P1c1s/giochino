class_name Adventurer extends CharacterBody2D

#const SPEED =300.0
const JUMP_VELOCITY = -400.0

var run_speed = 180.0
var attackMode			#flag variable to control attacks
var collisionEnemy 
var enemy : CharacterBody2D
var attackNumbers : int = 0

#var life: int

# attack sounds
@onready var state_machine = $AnimationTree["parameters/playback"]

#When the object is instanced the player has full life
func _ready() -> void:
	GameManager.restoreLife()
	attackMode = false
	collisionEnemy = false

func _physics_process(delta: float) -> void:
	var _current_anim = state_machine.get_current_node()
	
	#adds gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	#when pressed spacebar or enter or up arrow is assigned the jump velocity and the animation Jump
	#is played
	else:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			print("SALTO")		#stampa di prova
			velocity.y = JUMP_VELOCITY
			move_and_slide()
			state_machine.travel("Jump")
			return
	
	#manage the movements thowards left or right
	velocity.x = Input.get_axis("ui_left", "ui_right") * run_speed
	
	#if F is pressed the sword collisionbox is enabled, it's played the correct animation depending
	#on the player's movement (is he's running or standing still). The flag attackMode is set true.
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
		print("ADVENTURER ATTACKS")
		GameManager.giveDamage(enemy)
		attackNumbers += 1
	
	if !attackMode:
		$AreaAttacco/CollisionShape2D.disabled = true
	
	if velocity.x != 0:
		$Sprite2D.scale.x = sign(velocity.x)				#flip_h
		
		#RUOTARE LA HITBOX CON CENTRO DI ROTAZIONE IL CENTRO DELLO SPRITE
		
		$AreaAttacco/CollisionShape2D.scale.x = sign(velocity.x)
		$AreaAttacco/CollisionShape2D.position.x = sign(velocity.x)
	if velocity.length() > 0:
		state_machine.travel("Run")
	else:
		state_machine.travel("Idle")
	move_and_slide()


func _on_area_attacco_body_entered(body: CharacterBody2D) -> void:
	print("SOMEONE COLLIDED WITH SWORD")
	print(body.get_script().get_class())
	print(body is Ghoul)
	print(body is Cocodaemon)
	if (body is Cocodaemon) or (body is Ghoul):				#poi inserire anche gli altri nemici
		print("Cocodemone o Ghoul")
		collisionEnemy = true
		enemy = body

func _on_area_attacco_body_exited(body: CharacterBody2D) -> void:
	if (body is Cocodaemon) or (body is Ghoul):
		collisionEnemy = false

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack" or anim_name == "AttackRun":
		attackMode = false
		attackNumbers = 0



# CHARACTER BEHAVIOUR: 
#First: The character movement is controlled by the user. Arrows for left and right, up arrow and 
#		spacebar for jumping, F for attack (for mobile controlled with touchscreen buttons). 
#		When the player doesn't move, it is played the Idle animation
#When he collides with coins, he collects them. The coins are removed from the node tree and the coin 
#		counter is increased
#When he collides with lifepotion: the life is restored entirely. The progressbar is set to the value 100
#When he attacks an enemy: if the sword box collides with the hitbox of the enemy, he gives damage
#		to the enemy, whose lifebar decreases gradually. 
