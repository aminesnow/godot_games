class_name LevelGate
extends Area2D


export(Commons.PlayerPose) var playerPose
export(String, FILE) var targetLevel
export(String) var gateID = null

onready var playerPosition: Position2D = $PlayerPosition 




func _on_LevelGate_body_entered(_body):
	GameEvents.emit_signal("ChangeScene", gateID, targetLevel)
