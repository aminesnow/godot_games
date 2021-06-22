extends Control


func _ready():
	GameEvents.connect("PauseGame", self, "_on_pauseGame")
	GameEvents.connect("UnPauseGame", self, "_on_unpauseGame")

func _on_pauseGame():
	disable_interactables()
	$UI.set_pause_mode(Node.PAUSE_MODE_STOP)
	get_tree().paused = true
	
func _on_unpauseGame():
	enable_interactables()
	$UI.set_pause_mode(Node.PAUSE_MODE_PROCESS)
	if !PlayerInventory.open:
		get_tree().paused = false

func disable_interactables():
	var inters = get_tree().get_nodes_in_group("interactables")
	for inter in inters:
		inter.set_pause_mode(Node.PAUSE_MODE_STOP)

func enable_interactables():
	var inters = get_tree().get_nodes_in_group("interactables")
	for inter in inters:
		inter.set_pause_mode(Node.PAUSE_MODE_PROCESS)
