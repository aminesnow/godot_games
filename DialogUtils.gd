extends Node


func launch_dialog(parent: Node2D, timeline: String):
	var dial = Dialogic.start(timeline, false)
	dial.set_pause_mode(Node.PAUSE_MODE_PROCESS)
	parent.add_child(dial)
	dial.connect("timeline_start", self, '_pause_game')
	dial.connect("timeline_end", self, '_unpause_game')


func _pause_game(timeline_name):
	GameEvents.emit_signal("PauseGame")
	
func _unpause_game(timeline_name):
	GameEvents.emit_signal("UnPauseGame")
	
