extends Control


export(PackedScene) var startScene

onready var menuBtns = $MenuButtons
onready var saveMenu = $SaveMenu

func _ready():
	$AnimationPlayer.play("logo")
	saveMenu.visible = false
	saveMenu.startScene = startScene

func show_menu():
	menuBtns.visible = true
	$MenuButtons/Start.grab_focus()

func _on_Start_pressed():
	get_tree().change_scene_to(startScene)


func _on_Load_pressed():
	menuBtns.visible = false
	saveMenu.visible = true


func _on_Quit_pressed():
	get_tree().quit()


func _on_ExitSave_pressed():
	menuBtns.visible = true
	saveMenu.visible = false
