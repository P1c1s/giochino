extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0


func _physics_process(_delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * _delta

	#Gestisce il salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("Jump")
	
	if Input.is_action_just_pressed("ui_attack"):
		$AnimatedSprite2D.play("MainAttack")
		print("F pressed")
	
	#Gestisce i movimenti
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		$AnimatedSprite2D.flip_h = (direction == -1)	#flip è un booleano
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("Idle")
	

	move_and_slide()
