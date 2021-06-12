extends Control


func _ready():
	visible = false


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused
		if get_tree().paused:
			GameEvents.emit_signal("PauseGame")
		else:
			GameEvents.emit_signal("UnPauseGame")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Continue_pressed():
	get_tree().paused = false
	visible = false
	GameEvents.emit_signal("UnPauseGame")
