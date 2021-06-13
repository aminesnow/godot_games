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
	disable_interactables()
	get_tree().paused = true
	$PauseNode.visible = true
	GameEvents.emit_signal("PauseGame")

func unpause_game():
	enable_interactables()
	if !PlayerInventory.open:
		get_tree().paused = false
	$PauseNode.visible = false
	GameEvents.emit_signal("UnPauseGame")

func disable_interactables():
	var inters = get_tree().get_nodes_in_group("interactables")
	for inter in inters:
		inter.set_pause_mode(Node.PAUSE_MODE_STOP)

func enable_interactables():
	var inters = get_tree().get_nodes_in_group("interactables")
	for inter in inters:
		inter.set_pause_mode(Node.PAUSE_MODE_PROCESS)

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



func save(idx):
	pass
