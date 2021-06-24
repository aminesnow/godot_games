extends CanvasLayer


func _ready():
	$QuestJournal.visible = false
	GameEvents.connect("CloseAll", self, "close")
	refresh_quests()

func refresh_quests():
	for quest in QuestSystem.get_available_quests():
		print(quest.title)



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
