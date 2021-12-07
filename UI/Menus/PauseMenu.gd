extends CanvasLayer


func _ready():
	$PauseNode.visible = false
	$SaveNode.visible = false


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if $PauseNode.visible && !$SaveNode.visible:
			unpause_game()
		elif !$PauseNode.visible && !$SaveNode.visible:
			pause_game()

func pause_game():
	$PauseNode.visible = true
	GameEvents.emit_signal("PauseGame")

func unpause_game():
	$PauseNode.visible = false
	GameEvents.emit_signal("UnPauseGame")



func _on_Exit_pressed():
	get_tree().quit()


func _on_Continue_pressed():
	unpause_game()


func _on_Save_pressed():
	$PauseNode.visible = false
	$SaveNode.visible = true


func _on_ExitSave_pressed():
	$PauseNode.visible = true
	$SaveNode.visible = false
