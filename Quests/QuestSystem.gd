extends Node


onready var quests = $Quests
onready var available = $AvailableQuests
onready var completed = $CompletedQuest
onready var failed = $FailedQuests

func _ready():
	GameEvents.connect("QuestComplete", self, "on_quest_complete")
	GameEvents.connect("QuestFailed", self, "on_quest_failed")

func start_quest(quest_id: String):
	var quest: Quest = find_quest(quest_id)
	if quest:
		quests.remove_child(quest)
		available.add_child(quest)
		quest.start()

func find_quest(id: String):
	for quest in quests.get_children():
		if (quest as Quest).id == id:
			return quest
	return null

func is_quest_started(id: String):
	for quest in available.get_children():
		if (quest as Quest).id == id:
			return true
	return false

func is_quest_completed(id: String):
	for quest in completed.get_children():
		if (quest as Quest).id == id:
			return true
	return false

func on_quest_complete(quest: Quest):
	available.remove_child(quest)
	completed.add_child(quest)

func on_quest_failed(quest: Quest):
	available.remove_child(quest)
	failed.add_child(quest)

func get_available_quests():
	return available.get_children()
