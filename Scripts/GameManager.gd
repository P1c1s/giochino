# This script is an autoload, that can be accessed from any other script!
extends Node2D

var coin = load("res://Assets/Music/Coin.mp3")
var potion = load("res://Assets/Music/LifePotion.mp3")
var attack = load("res://Assets/Music/Attack.mp3")
var treasure = load("res://Assets/Music/Treasure.mp3")
var audio_player = AudioStreamPlayer.new()

var score : int = 0
var adventurerLife : int = 100

var keyCollected : bool 

func _ready() -> void:
	add_child(audio_player)

# Adds 1 to score variable
func addOneScore():
	score += 1
	audio_player.stream = coin
	audio_player.play()
	
# Adds 1 to score variable
func addKeyScore():
	audio_player.stream = coin
	audio_player.play()

func addChestScore():
	score += 20
	audio_player.stream = treasure
	audio_player.play()

func getDamage():
	adventurerLife -= 10
	#print("Adventurer ha preso danno")

func giveDamage(enemy : CharacterBody2D):
	#Manager deve togliere vita a nemico
	enemy.life -= 20
	audio_player.stream = attack
	audio_player.play()

func restoreLife():
	adventurerLife = 100
	audio_player.stream = potion
	audio_player.play()

#last level's character damage
func deathAttack():
	adventurerLife = 0

func checkLife() -> int:
	return adventurerLife

# Loads next level
func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)

func setKeyCollected():
	keyCollected = true

func isKeyCollected() -> bool:
	return keyCollected

func initKeyCollected():
	keyCollected = false

func gameover():
	get_tree().change_scene_to_file("res://Scenes/Menus/GameOver.tscn")
	
