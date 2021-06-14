extends Node

var open = false

var slots = {}
var weapon_slot: WeaponItem

func get_save_data():
	var ws = null
	if weapon_slot != null:
		ws = weapon_slot.filename
	var inv =  {
		"weapon": ws,
		"slots": {}
	}
	
	for slot in slots:
		var item_filename = null
		var quantity = 0
		if slots[slot] != null:
			item_filename = slots[slot].filename
			quantity = slots[slot].quantity

		inv["slots"][slot] = {
			"quantity": quantity,
			"item": item_filename
		}
	return inv
