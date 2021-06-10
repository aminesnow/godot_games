extends CanvasLayer



func _input(event):
	if event.is_action_pressed("inventory"):
		if $Inventory.visible:
			GameEvents.emit_signal("CloseInventory")
		else:
			GameEvents.emit_signal("OpenInventory")

func _ready():
	$Inventory.visible = false
	GameEvents.connect("OpenInventory", self, "open")
	GameEvents.connect("CloseInventory", self, "close")
	GameEvents.connect("OpenContainer", self, "open_with_container")
	GameEvents.connect("CloseContainer", self, "close")


func open():
	$Inventory.visible = true

func open_with_container(_id, _items):
	open()

func close():
	$Inventory.visible = false
