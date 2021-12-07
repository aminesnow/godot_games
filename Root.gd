extends Node2D

onready var levels = $Levels
var startLevelPath = "res://Levels/L1.tscn"

export(PackedScene) var endGameScene

func _ready():
	change_level()
	QuestSystem.start_quest("talk_quest")
	GameEvents.connect("QuestComplete", self, "check_game_over", [true])
	GameEvents.connect("QuestFailed", self, "check_game_over", [false])
	GameEvents.connect("PlayerDead", self, "player_dead")

func change_level():
	if levels.get_child_count() > 0:
		var old_level = levels.get_child(0)
		levels.remove_child(old_level)
		old_level.call_deferred("queue_free")

	# Add the next level
	var level = load(startLevelPath).instance()
	levels.add_child(level)

func check_game_over(quest: Quest, won: bool):
	if quest.id == "kill_bats":
		to_outro(won)

func player_dead():
	to_outro(false)

func to_outro(won: bool):
	yield(get_tree().create_timer(2), "timeout")
	var endGame = endGameScene.instance()
	endGame.win = won
	endGame.init_text()
	get_tree().get_root().add_child(endGame)
	get_tree().get_root().remove_child(self)
	self.call_deferred("free")
