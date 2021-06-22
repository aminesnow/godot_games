extends KinematicBody2D


onready var sprite = $Sprite 
onready var animationTree = $AnimationTree

var convo = "oldman1_chat1"

func _ready():
	animationTree.active = true

func interact(interactor):
	var dial = Dialogic.start(convo, false)
	dial.set_pause_mode(Node.PAUSE_MODE_PROCESS)
	add_child(dial)
	print(interactor.position - self.position)
	var pose = Commons.position_to_pose(interactor.position - self.position)
	var poseVector = Commons.PoseVectors[pose]
	animationTree.set("parameters/Idle/blend_position", poseVector)
	print(pose)
	print(Commons.get_opposite_pose(pose))
	dial.connect("timeline_start", self, '_pause_game')
	dial.connect("timeline_end", self, '_unpause_game')

func _pause_game(timeline_name):
	GameEvents.emit_signal("PauseGame")
	
func _unpause_game(timeline_name):
	GameEvents.emit_signal("UnPauseGame")
	
