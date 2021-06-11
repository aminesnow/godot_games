extends Control


func _input(event):
	if event.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
