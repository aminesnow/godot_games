extends Node


var containers_slot = {}

func reset():
	for key in containers_slot:
		if containers_slot[key] != null && is_instance_valid(containers_slot[key]):
			containers_slot[key].queue_free()
	 containers_slot = {}

func get_save_data():
	var inv = {}
	for container_key in containers_slot:
		inv[container_key] = {}
		var items = containers_slot[container_key]
		for slot in items:
			if items[slot] != null:
				var item = null
				var quantity = 0
				item = items[slot].filename
				quantity = items[slot].quantity
				inv[container_key][slot] = {
						"item": item,
						"quantity": quantity
					}
	return inv 


func load_save_data(data):
	for container_key in data:
		containers_slot[container_key] = {}
		var container_slots = data[container_key]
		for slot_key in container_slots:
			if container_slots[slot_key].item != null:
				var item = load(container_slots[slot_key].item).instance()
				item.set_quantity(container_slots[slot_key].quantity)
				containers_slot[container_key][slot_key] = item
