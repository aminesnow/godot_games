extends Slot


func init_slot():
	if PlayerInventory.slots.has(idx):
		item = PlayerInventory.slots[idx]
		item.position = Vector2(0, 0)
		add_child(item)

func pickFromSlot():
	.pickFromSlot()
	update_inventory()
	
func putIntoSlot(new_item):
	.putIntoSlot(new_item)
	update_inventory()

func update_inventory():
	PlayerInventory.slots[idx] = item
