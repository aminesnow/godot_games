class_name AbstractLevel
extends Node2D

signal SceneReady

onready var sceneChanger = SceneChanger

var player = null

func ready():
	player.connect("PlayerDead", self, "_on_Player_PlayerDead")
	player.connect("PlayerReady", self, "_on_Player_PlayerReady")


func _on_Player_PlayerDead():
	print("game over")

func _on_Player_PlayerReady():
	sceneChanger.finish_change_scene(0.2)
	player.disconnect("PlayerReady", self, "_on_Player_PlayerReady")
