class_name ContainerSlot
extends Slot

var container_id: String

func init_slot():
	if ContainersInventory.containers_slot.has(container_id) \
	  && ContainersInventory.containers_slot[container_id].has(idx):
		item = ContainersInventory.containers_slot[container_id][idx]
		item.position = Vector2(0, 0)
		add_child(item)

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
