# This script is an autoload, that can be accessed from any other script!
extends Node2D

var score : int = 0
var adventurerLife : int = 100

# Adds 1 to score variable
func add_score():
	score += 1

func getDamage():
	adventurerLife -= 50
	print("Adventurer ha preso danno")

func giveDamage(enemy : CharacterBody2D):
	print("Manager deve togliere vita a nemico")
	enemy.life -= 20

func restoreLife():
	adventurerLife = 100

# Loads next level
func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)
