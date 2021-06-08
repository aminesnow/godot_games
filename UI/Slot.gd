class_name InventorySlot
extends Panel


var sword = preload("res://Items/Sword.tscn")
var mace = preload("res://Items/Mace.tscn")
var potion = preload("res://Items/Potion.tscn")
var item: Item = null

func _ready():
	randomize()
	if randi() % 2 == 0:
		if randi() % 3 == 0:
			item = sword.instance()
		else:
			item = potion.instance()
	elif randi() % 3 == 0:
		item = mace.instance()
	
	if item:
		add_child(item)
	self.connect("gui_input", self, "_on_guiInput")

func pickFromSlot():
	remove_child(item)
	find_parent("Inventory").add_child(item)
	item = null
	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	find_parent("Inventory").remove_child(item)
	add_child(item)

func _on_guiInput(event: InputEvent):
	if event is InputEventMouseButton:
		var mouseEvent: InputEventMouseButton = event
		if mouseEvent.button_index == BUTTON_LEFT && event.pressed:
			GameEvents.emit_signal("SlotClicked", event, self)
