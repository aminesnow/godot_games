extends CanvasLayer



func _input(event):
	if event.is_action_pressed("inventory"):
		if $Inventory.visible:
			GameEvents.emit_signal("CloseInventory")
			GameEvents.emit_signal("HideSlotPopup")
			get_tree().paused = false
		else:
			GameEvents.emit_signal("CloseAll")
			GameEvents.emit_signal("OpenInventory")
			get_tree().paused = true

func _ready():
	$Inventory.visible = false
	GameEvents.connect("OpenInventory", self, "open")
	GameEvents.connect("CloseInventory", self, "close")
	GameEvents.connect("OpenContainer", self, "open_with_container")
	GameEvents.connect("CloseContainer", self, "close")
	GameEvents.connect("CloseAll", self, "close")


func open():
	$Inventory.visible = true
	PlayerInventory.open = true

func open_with_container(_id, _items):
	open()

func close():
	$Inventory.visible = false
	PlayerInventory.open = false
