extends CanvasLayer

onready var vbox = $QuestJournal/Control/ScrollContainer/VBoxContainer

var questUIScene = preload("res://UI/Quests/SingleQuestUI.tscn")

func _ready():
	$QuestJournal.visible = false
	GameEvents.connect("CloseAll", self, "close")
	GameEvents.connect("QuestComplete", self, "refresh_quests")
	GameEvents.connect("QuestStarted", self, "refresh_quests")
	GameEvents.connect("QuestFailed", self, "refresh_quests")
	refresh_quests(null)

func refresh_quests(_quest):
	for q in vbox.get_children():
		vbox.remove_child(q)

	for quest in QuestSystem.get_available_quests():
		var questui = questUIScene.instance()
		vbox.add_child(questui)
		questui.set_title(quest.title)
		questui.set_description(quest.description)


func _input(event):
	if event.is_action_pressed("quests"):
		toggle()

func _on_TextureButton_pressed():
	toggle()

func toggle():
	if $QuestJournal.visible:
			close()
	else:
		open()

func open():
	GameEvents.emit_signal("CloseAll")
	$QuestJournal.visible = true
	get_tree().paused = true

func close():
	$QuestJournal.visible = false
	get_tree().paused = false
