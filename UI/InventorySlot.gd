extends Slot


func pickFromSlot():
	.pickFromSlot()
	update_inventory()
	
func putIntoSlot(new_item):
	.putIntoSlot(new_item)
	update_inventory()

func update_inventory():
	PlayerInventory.slots[idx] = item
