# This script is an autoload, that can be accessed from any other script!
extends Node2D

var sound = load("res://Assets/Music/Coin.mp3")
var audio_player = AudioStreamPlayer.new()


var score : int = 0
var adventurerLife : int = 100

var keyCollected : bool 

# Adds 1 to score variable
func addOneScore():
	score += 1
	add_child(audio_player)
	audio_player.stream = sound
	audio_player.play()

func addChestScore():
	score += 20
	add_child(audio_player)
	audio_player.stream = sound
	audio_player.play()

func getDamage():
	adventurerLife -= 10
	#print("Adventurer ha preso danno")

func giveDamage(enemy : CharacterBody2D):
	#print("Manager deve togliere vita a nemico")
	enemy.life -= 20

func restoreLife():
	adventurerLife = 100

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
	
