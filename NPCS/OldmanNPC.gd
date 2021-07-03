extends KinematicBody2D


onready var sprite = $Sprite 
onready var animationTree = $AnimationTree

var convo = "oldman1_chat1"
var convo2 = "oldman1_chat2"
var quest_given = false

export(Array) var quests_to_give

func _ready():
	animationTree.active = true

func interact(interactor):
	if !quest_given:
		DialogUtils.launch_dialog(self, convo)
		for quest in quests_to_give:
			QuestSystem.start_quest(quest)
			quest_given = true
	else:
		DialogUtils.launch_dialog(self, convo2)
	
	var pose = Commons.position_to_pose(interactor.position - self.position)
	var poseVector = Commons.PoseVectors[pose]
	animationTree.set("parameters/Idle/blend_position", poseVector)
	GameEvents.emit_signal("Talking", self)
