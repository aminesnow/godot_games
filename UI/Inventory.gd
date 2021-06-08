extends Node2D


var holding_item: Item = null

func _ready():
	GameEvents.connect("SlotClicked", self, "_on_slotClicked")

func _on_slotClicked(event: InputEvent, slot: InventorySlot):
	if holding_item:
		if !slot.item:
			slot.putIntoSlot(holding_item)
			holding_item = null
		else:
			if holding_item.label == slot.item.label:
				var able_to_add = slot.item.stack_size - slot.item.quantity
				if able_to_add >= holding_item.quantity:
					slot.item.add_quantity(holding_item.quantity)
					holding_item.queue_free()
					holding_item = null
				else:
					slot.item.add_quantity(able_to_add)
					holding_item.add_quantity(-able_to_add)
			else:
				var temp_item = slot.item
				slot.pickFromSlot()
				temp_item.global_position = get_global_mouse_position()
				slot.putIntoSlot(holding_item)
				holding_item = temp_item
	elif slot.item:
		holding_item = slot.item
		slot.pickFromSlot()
		holding_item.global_position = get_global_mouse_position()

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
