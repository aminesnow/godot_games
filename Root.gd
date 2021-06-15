extends Node2D

onready var levels = $Levels

func change_level(level_path):
	var next_level = load(level_path).instance()
	var old_level = levels.get_child(0)
	levels.remove_child(old_level)
	old_level.call_deferred("queue_free")

	# Add the next level
	levels.add_child(next_level)
