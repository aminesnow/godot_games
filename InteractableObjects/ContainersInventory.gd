extends Node


var containers_slot = {}

func get_save_data():
	var inv = []
	for container_key in containers_slot:
		var container = {
			"key": container_key,
			"slots": []
		}
		var items = containers_slot[container_key]
		for slot in items:
			if items[slot] != null:
				var item = null
				var quantity = 0
				item = items[slot].filename
				quantity = items[slot].quantity
				container["slots"].push_back({
						"slot": slot,
						"item": item,
						"quantity": quantity
					})
		inv.push_back(container)
	return inv 
