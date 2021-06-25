extends KinematicBody2D


onready var sprite = $Sprite 
onready var animationTree = $AnimationTree

var convo = "oldman1_chat1"

export(Array) var quests_to_give

func _ready():
	animationTree.active = true

func interact(interactor):
	var dial = Dialogic.start(convo, false)
	dial.set_pause_mode(Node.PAUSE_MODE_PROCESS)
	add_child(dial)

	var pose = Commons.position_to_pose(interactor.position - self.position)
	var poseVector = Commons.PoseVectors[pose]
	animationTree.set("parameters/Idle/blend_position", poseVector)

	dial.connect("timeline_start", self, '_pause_game')
	dial.connect("timeline_end", self, '_unpause_game')
	GameEvents.emit_signal("Talking", self)
	
	for quest in quests_to_give:
		QuestSystem.start_quest(quest)

func _pause_game(timeline_name):
	GameEvents.emit_signal("PauseGame")
	
func _unpause_game(timeline_name):
	GameEvents.emit_signal("UnPauseGame")
	
