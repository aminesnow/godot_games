extends Node2D

onready var levels = $Levels
var startLevelPath = "res://Levels/L1.tscn"

func _ready():
	change_level()
	QuestSystem.start_quest("talk_quest")

func change_level():
	if levels.get_child_count() > 0:
		var old_level = levels.get_child(0)
		levels.remove_child(old_level)
		old_level.call_deferred("queue_free")

	# Add the next level
	var level = load(startLevelPath).instance()
	levels.add_child(level)
