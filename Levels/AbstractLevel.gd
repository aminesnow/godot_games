class_name AbstractLevel
extends Node2D

export(PackedScene) var endGameScene

var player = null

func ready():
	pass

func set_player_position(playerPosition: Vector2):
	player.global_position = playerPosition
