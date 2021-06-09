extends CanvasLayer


func _ready():
	$Inventory.visible = false
	GameEvents.connect("CloseInventory", self, "close")
	GameEvents.connect("OpenContainer", self, "open")
	GameEvents.connect("CloseContainer", self, "close")


func open():
	$Inventory.visible = true

func close():
	$Inventory.visible = false
