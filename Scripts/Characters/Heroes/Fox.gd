class_name Fox extends CharacterBody2D

const JUMP_VELOCITY = -300.0

@export var limit = 50

var run_speed = 50.0
var gravita = 800.0

var player_chase = false
var player = null

@onready var timer = $Timer

# attack sounds
@onready var state_machine = $AnimationTree["parameters/playback"]


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Adventurer:
		player = body
		player_chase = true
		print("Player detected")

func _physics_process(delta: float) -> void:
	velocity += get_gravity() *delta
	move_and_slide()
	
	var flip = false
	
	if player_chase:
		if abs(player.position.x - position.x) > limit:
			position.x += (player.position.x - position.x)/run_speed
			flip = (player.position.x < position.x)
			$Sprite2D.flip_h = flip
			state_machine.travel("Run")
		if not (player.velocity.length() > 0 or abs(player.position.x - position.x) >= 10):
			state_machine.travel("Idle")
			#idle deve partire anche quando il personaggio è fermo e la fox lo ha raggiunt
		
		if (position.y - player.position.y) > 50 and (position.y - player.position.y) < 250  or get_slide_collision_count() > 1: #se il personaggio sta più in alto la fox salta
			velocity.y = JUMP_VELOCITY
			state_machine.travel("Jump")
			move_and_slide()
			print(get_slide_collision_count())
		
		if Input.is_action_just_pressed("ui_accept"):
			timer.start(0.8)


func _on_timer_timeout() -> void:
	velocity.y = JUMP_VELOCITY
	state_machine.travel("Jump")
	move_and_slide()
