extends Node
class_name Quest


var title
var description
export(int) var money_reward
export(String) var id

onready var objectives = $Objectives
onready var itemRewards = $ItemRewards

var completedObjectives = []


func _ready():
	title = JsonData.quest_data[id]["title"]
	description = JsonData.quest_data[id]["description"]

func get_save_data():
	var data = {
		"objectives": {},
		"completedObjectives": completedObjectives,
	}

	for objective in objectives.get_children():
		data["objectives"][objective.id] = objective.get_save_data()
	
	return data

func load_save_data(data):
	completedObjectives = data["completedObjectives"]
	for objective in objectives.get_children():
		objective.load_save_data(data["objectives"][objective.id])

func reset():
	completedObjectives = []
	for objective in objectives.get_children():
		objective.disconnect("completed", self, "on_objective_complete")
		objective.disconnect("failed", self, "on_objective_failed")
		objective.reset()

func start():
	for objective in objectives.get_children():
		objective.connect("completed", self, "on_objective_complete")
		objective.connect("failed", self, "on_objective_failed")
		objective.start()
	GameEvents.emit_signal("QuestStarted", self)

func on_objective_complete(obj):
	completedObjectives.push_back(obj.id)
	if objectives.get_child_count() == completedObjectives.size():
		GameEvents.emit_signal("QuestComplete", self)

func on_objective_failed(obj):
	GameEvents.emit_signal("QuestFailed", self)

func get_rewards():
	return {
		"items": itemRewards.get_children(),
		"money": money_reward
	}
