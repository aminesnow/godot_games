extends CanvasLayer


signal SceneChanged

onready var animation_player = $AnimationPlayer
onready var colorRect = $Control/ColorRect

var gateID: String
var changingScene = false

func start_change_scene(sourceGateID, targetScene: String, delay = 0.0):
	if !changingScene:
		changingScene = true
		self.gateID = sourceGateID
		yield(get_tree().create_timer(delay), "timeout")
		animation_player.play("Fade")
		yield(animation_player, "animation_finished")
		assert(get_tree().change_scene(targetScene) == OK)
		emit_signal("SceneChanged")

func finish_change_scene(delay):
	if changingScene:
		changingScene = false
		yield(get_tree().create_timer(delay), "timeout")
		animation_player.play_backwards("Fade")
		yield(animation_player, "animation_finished")
