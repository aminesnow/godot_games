class_name ContainerSlot
extends Slot

var container_id: String

func pickFromSlot():
	.pickFromSlot()
	update_inventory()
	
func putIntoSlot(new_item):
	.putIntoSlot(new_item)
	update_inventory()

func update_inventory():
	if ContainersInventory.containers_slot.has(container_id):
		ContainersInventory.containers_slot[container_id][idx] = item
	elif item != null:
		ContainersInventory.containers_slot[container_id] = {
			idx: item
		}
