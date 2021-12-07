extends Node


onready var quests = $Quests
onready var available = $AvailableQuests
onready var completed = $CompletedQuest
onready var failed = $FailedQuests

func get_save_data():
	var save_data = {
		"quests": {},
		"available": {},
		"completed": {},
		"failed": {},
	}
	
	for quest in quests.get_children():
		save_data["quests"][quest.id] = quest.get_save_data()
	
	for quest in available.get_children():
		save_data["available"][quest.id] = quest.get_save_data()
	
	for quest in completed.get_children():
		save_data["completed"][quest.id] = quest.get_save_data()
	
	for quest in failed.get_children():
		save_data["failed"][quest.id] = quest.get_save_data()
	
	return save_data

func load_save_data(data):
	reset()
	
	for quest_id in data["available"]:
		var quest: Quest = find_quest(quest_id)
		if quest:
			quest.load_save_data(data["available"][quest_id])
			start_quest(quest_id)
	
	for quest_id in data["completed"]:
		var quest: Quest = find_quest(quest_id)
		if quest:
			quests.remove_child(quest)
			completed.add_child(quest)
			quest.load_save_data(data["completed"][quest_id])
	
	for quest_id in data["failed"]:
		var quest: Quest = find_quest(quest_id)
		if quest:
			quests.remove_child(quest)
			failed.add_child(quest)
			quest.load_save_data(data["failed"][quest_id])

func _ready():
	GameEvents.connect("QuestComplete", self, "on_quest_complete")
	GameEvents.connect("QuestFailed", self, "on_quest_failed")

func reset():
	for quest in available.get_children():
		(quest as Quest).reset()
		available.remove_child(quest)
		quests.add_child(quest)

	for quest in completed.get_children():
		(quest as Quest).reset()
		completed.remove_child(quest)
		quests.add_child(quest)

	for quest in failed.get_children():
		(quest as Quest).reset()
		failed.remove_child(quest)
		quests.add_child(quest)

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
