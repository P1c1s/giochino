extends CharacterBody2D

const JUMP_VELOCITY = -300.0

@export var limit = 50

var run_speed = 50.0
var gravita = 800.0

var player_chase = false
var player = null

@onready var timer = $Timer

# attack sounds
@onready var state_machine = $AnimationTree["parameters/playback"]

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#var current_anim = state_machine.get_current_node()
	#
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	#else:
		#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			#print("SALTO")		#stampa di prova
			#velocity.y = JUMP_VELOCITY
			#move_and_slide()
			#state_machine.travel("Jump")
			#return
	#
	#velocity.x = Input.get_axis("ui_left", "ui_right") * run_speed
	#
	#
	#if velocity.x != 0:
		#$Sprite2D.scale.x = sign(velocity.x)
	#if velocity.length() > 0:
		#state_machine.travel("Run")
	#else:
		#state_machine.travel("Idle")
	#move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true
	print("Player detected")

func _physics_process(delta: float) -> void:
	velocity += get_gravity() *delta
	var collision = get_slide_collision_count()
	move_and_slide()
	
	var flip = false
	
	if player_chase:
		if abs(player.position.x - position.x) > limit:
			position.x += (player.position.x - position.x)/run_speed
			flip = (player.position.x < position.x)
			$Sprite2D.flip_h = flip
			state_machine.travel("Run")
		if not (player.velocity.length() > 0 or abs(player.position.x - position.x) > limit):
			state_machine.travel("Idle")
		
		if (position.y - player.position.y) > 50 and collision > 0: #se il personaggio sta più in alto la fox salta
			print("Stronzo più in alto")
			velocity.y = JUMP_VELOCITY
			state_machine.travel("Jump")
			move_and_slide()
		
		if Input.is_action_just_pressed("ui_accept"):
			timer.start(0.8)


func _on_timer_timeout() -> void:
	velocity.y = JUMP_VELOCITY
	state_machine.travel("Jump")
	move_and_slide()
