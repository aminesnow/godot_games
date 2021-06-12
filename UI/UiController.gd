extends Control


func _ready():
	GameEvents.connect("PauseGame", self, "_on_pauseGame")
	GameEvents.connect("UnPauseGame", self, "_on_unpauseGame")

func _on_pauseGame():
	$UI.set_pause_mode(Node.PAUSE_MODE_STOP)
	
func _on_unpauseGame():
	$UI.set_pause_mode(Node.PAUSE_MODE_PROCESS)
