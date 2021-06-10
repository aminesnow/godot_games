extends Node2D

var uiNode

func _ready():
	GameEvents.connect("SlotClicked", self, "_on_slotClicked")
	uiNode = find_parent("UI")

func _on_slotClicked(event: InputEvent, slot: Slot):
	
	if slot.find_parent("Inventory") == self or slot.item == uiNode.holding_item:
		if uiNode.holding_item:
			if !slot.item:
				slot.putIntoSlot(uiNode.holding_item)
				uiNode.holding_item = null
			else:
				if uiNode.holding_item.label == slot.item.label:
					var able_to_add = slot.item.stack_size - slot.item.quantity
					if able_to_add >= uiNode.holding_item.quantity:
						slot.item.add_quantity(uiNode.holding_item.quantity)
						uiNode.holding_item.queue_free()
						uiNode.holding_item = null
					else:
						slot.item.add_quantity(able_to_add)
						uiNode.holding_item.add_quantity(-able_to_add)
				else:
					var temp_item = slot.item
					slot.pickFromSlot()
					temp_item.global_position = get_global_mouse_position()
					slot.putIntoSlot(uiNode.holding_item)
					uiNode.holding_item = temp_item
		elif slot.item:
			uiNode.holding_item = slot.item
			slot.pickFromSlot()
			uiNode.holding_item.global_position = get_global_mouse_position()

func _input(event):
	if uiNode.holding_item:
		uiNode.holding_item.global_position = get_global_mouse_position()
