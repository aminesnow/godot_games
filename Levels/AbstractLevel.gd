class_name AbstractLevel
extends Node2D

var player = null

func ready():
	GameEvents.connect("PlayerDead", self, "_on_Player_PlayerDead")

func _on_Player_PlayerDead():
	print("game over")

func set_player_position(playerPosition: Vector2):
	player.global_position = playerPosition
