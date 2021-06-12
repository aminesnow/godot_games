class_name Slot
extends Panel

onready var uiNode: UI = find_parent("UI")
export(int) var idx
var item: Item = null

func _ready():
	randomize()
	self.connect("gui_input", self, "_on_guiInput")
	self.connect("mouse_entered", self, "_on_Slot_mouse_entered")
	self.connect("mouse_exited", self, "_on_Slot_mouse_exited")
	update_inventory()


func _on_Slot_mouse_entered():
	if item != null and uiNode.holding_item == null:
		GameEvents.emit_signal("ShowSlotPopup", item)


func _on_Slot_mouse_exited():
	GameEvents.emit_signal("HideSlotPopup")

func pickFromSlot():
	remove_child(item)
	find_parent("UI").add_child(item)
	item = null

func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	find_parent("UI").remove_child(item)
	add_child(item)

func _on_guiInput(event: InputEvent):
	if event is InputEventMouseButton:
		var mouseEvent: InputEventMouseButton = event
		process_click(mouseEvent)

func process_click(event: InputEventMouseButton):
	if event.button_index == BUTTON_LEFT && event.pressed:
		GameEvents.emit_signal("SlotClicked", self)

	if item != null and event.is_action_pressed("consume") and item.category == Item.CATEGORY_Consumable:
		item.consume()

func update_inventory():
	pass
