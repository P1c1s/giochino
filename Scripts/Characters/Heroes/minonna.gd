extends CharacterBody2D

var run_speed = 80.0
var attacks = ["Attack"]

const JUMP_VELOCITY = 300.0

# attack sounds
@onready var state_machine = $AnimationTree["parameters/playback"]

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity()*delta
	
	var current_anim = state_machine.get_current_node()
	if current_anim in ["hurt", "die"]:
		return
		
	velocity.x = Input.get_axis("ui_left", "ui_right") * run_speed
	if Input.is_action_just_pressed("ui_attack"):
		print("ATTACCO")		#stampa di prova
		state_machine.travel(attacks.pick_random())
		return
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		print("SALTO")		#stampa di prova
		velocity.y = JUMP_VELOCITY
		state_machine.travel("Jump")
		return
	
	if velocity.x != 0:
		$Sprite2D.scale.x = sign(velocity.x)
	if velocity.length() > 0:
		state_machine.travel("Run")
	else:
		state_machine.travel("Idle")
	move_and_slide()

#func hurt():
	#state_machine.travel("hurt")
	#
#func die():
	#state_machine.travel("die")
	#set_physics_process(false)
#
#func _on_sword_hit_area_entered(area):
	#if area.is_in_group("hurtbox"):
		#area.take_damage()
