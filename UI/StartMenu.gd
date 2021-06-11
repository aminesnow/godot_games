extends Control


export(PackedScene) var startScene

func _ready():
	$AnimationPlayer.play("logo")

func show_menu():
	$VBoxContainer.visible = true
	$VBoxContainer/Start.grab_focus()

func _on_Start_pressed():
	get_tree().change_scene_to(startScene)


func _on_Load_pressed():
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
