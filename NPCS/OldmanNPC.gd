extends KinematicBody2D


onready var sprite = $Sprite 
onready var animationTree = $AnimationTree

var convo = "oldman1_chat1"
var convo2 = "oldman1_chat2"

export(Array) var quests_to_give

func _ready():
	animationTree.active = true

func interact(interactor):
	if !QuestSystem.is_quest_started(quests_to_give[1]): #kill_bats
		DialogUtils.launch_dialog(self, convo)
		for quest in quests_to_give:
			QuestSystem.start_quest(quest)
	else:
		DialogUtils.launch_dialog(self, convo2)
	
	var pose = Commons.position_to_pose(interactor.position - self.position)
	var poseVector = Commons.PoseVectors[pose]
	animationTree.set("parameters/Idle/blend_position", poseVector)
	GameEvents.emit_signal("Talking", self)
