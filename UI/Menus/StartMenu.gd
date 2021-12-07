extends Control


export(PackedScene) var nextScene

onready var menuBtns = $MenuButtons
onready var saveMenu = $SaveMenu

func _ready():
	PlayerInventory.reset()
	ContainersInventory.reset()
	PlayerStats.reset()
	QuestSystem.reset()
	$AnimationPlayer.play("logo")
	saveMenu.visible = false

func show_menu():
	menuBtns.visible = true
	$MenuButtons/Start.grab_focus()

func _on_Start_pressed():
	get_tree().change_scene_to(nextScene)


func _on_Load_pressed():
	menuBtns.visible = false
	saveMenu.visible = true


func _on_Quit_pressed():
	get_tree().quit()


func _on_ExitSave_pressed():
	menuBtns.visible = true
	saveMenu.visible = false
