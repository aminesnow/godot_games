extends Node
class_name QuestSystem


onready var quests = $Quests
onready var available = $AvailableQuests
onready var completed = $CompletedQuest

func _ready():
	GameEvents.connect("QuestComplete", self, "on_quest_complete")


func start_quest(quest_filename: String):
	for quest in quests.get_children():
		if (quest as Quest).filename == quest_filename:
			quests.remove_child(quest)
			available.add_child(quest)
			quest.start()
			return 

func on_quest_complete(quest: Quest):
	available.remove_child(quest)
	completed.add_child(quest)
