class_name Mostro extends CharacterBody2D

var life: int

@export var speed = 40
@export var limit = 0.5

@onready var state_machine = $AnimationTree["parameters/playback"]

var target: CharacterBody2D

func _ready():
	life = 100
	

func _physics_process(delta: float) -> void:
	
	if life == 0:
		state_machine.travel("Die");
