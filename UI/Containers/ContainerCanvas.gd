extends CanvasLayer


func _ready():
	$Inventory.visible = false
	GameEvents.connect("CloseInventory", self, "close")
	GameEvents.connect("OpenContainer", self, "open")
	GameEvents.connect("CloseContainer", self, "close")
	GameEvents.connect("CloseAll", self, "close")


func open(id: String, containerItems: Dictionary):
	for key in containerItems:
		var slot: Slot = $Inventory/GridContainer.get_child(key)
		slot.item = containerItems[key]
		slot.container_id = id
		slot.update_inventory()
		if slot.item != null:
			slot.add_child(slot.item)
	$Inventory.visible = true

func close():
	var slots = $Inventory/GridContainer.get_children()
	for slot in slots:
		if slot.item != null:
			slot.remove_child(slot.item)
			slot.item = null
	$Inventory.visible = false
