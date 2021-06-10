class_name Slot
extends Panel


var item: Item = null
export(int) var idx

func _ready():
	randomize()
	self.connect("gui_input", self, "_on_guiInput")
	update_inventory()

func pickFromSlot():
	remove_child(item)
	find_parent("UI").add_child(item)
	item = null
	update_inventory()
	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	find_parent("UI").remove_child(item)
	add_child(item)
	update_inventory()

func _on_guiInput(event: InputEvent):
	if event is InputEventMouseButton:
		var mouseEvent: InputEventMouseButton = event
		if mouseEvent.button_index == BUTTON_LEFT && event.pressed:
			GameEvents.emit_signal("SlotClicked", event, self)

func update_inventory():
	pass
