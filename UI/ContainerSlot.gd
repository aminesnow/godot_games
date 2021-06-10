class_name ContainerSlot
extends Slot

var container_id: String

func update_inventory():
	if ContainersInventory.containers_slot.has(container_id):
		ContainersInventory.containers_slot[container_id][idx] = item
	elif item != null:
		ContainersInventory.containers_slot[container_id] = {
			idx: item
		}
