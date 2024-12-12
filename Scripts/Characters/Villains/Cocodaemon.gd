extends CharacterBody2D


@export var speed = 40
@export var limit = 0.5

var gravita = 140.00

var startPosition
var endPosition

func _ready():
	
	#l'aggiunta della gravità non funziona, probabilmente per l'assegnazion
	#startPosition = position, in cui fissiamo anche l'ordinata
	#if not is_on_floor():
		#velocity += get_gravity() * gravita
	#move_and_slide()
	#
	
	startPosition = position
	endPosition = startPosition - Vector2(50, 0)
	$Sprite2D.flip_h = true

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		changeDirection()
		$Sprite2D.flip_h = !$Sprite2D.flip_h
	
	velocity = moveDirection.normalized()*speed

func _physics_process(delta: float) -> void:	
	updateVelocity()
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
