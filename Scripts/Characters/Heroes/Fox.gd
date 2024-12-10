extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0

var run_speed = 80.0

# attack sounds
@onready var state_machine = $AnimationTree["parameters/playback"]


func _physics_process(delta: float) -> void:
	# Add the gravity.
	var current_anim = state_machine.get_current_node()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			print("SALTO")		#stampa di prova
			velocity.y = JUMP_VELOCITY
			move_and_slide()
			state_machine.travel("Jump")
			return
	
	
	velocity.x = Input.get_axis("ui_left", "ui_right") * run_speed
	
	
	
	if velocity.x != 0:
		$Sprite2D.scale.x = sign(velocity.x)
	if velocity.length() > 0:
		state_machine.travel("Run")
	else:
		state_machine.travel("Idle")
	move_and_slide()


	##Gestisce il salto
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		#$AnimatedSprite2D.play("MainAttack")
	#
	##Gestisce i movimenti
	#var direction = Input.get_axis("ui_left", "ui_right")
	#
	#if direction != 0:
		#$AnimatedSprite2D.flip_h = (direction == -1)	#flip è un booleano
	#if direction:
		#velocity.x = direction * SPEED
		#$AnimatedSprite2D.play("Run")
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#$AnimatedSprite2D.play("Look")
#
	#move_and_slide()
