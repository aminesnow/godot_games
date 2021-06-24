extends Node


onready var quests = $Quests
onready var available = $AvailableQuests
onready var completed = $CompletedQuest

func _ready():
	GameEvents.connect("QuestComplete", self, "on_quest_complete")
	# TODO load quests from save
	start_quest(quests.get_child(0).filename)

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

func get_available_quests():
	return available.get_children()
