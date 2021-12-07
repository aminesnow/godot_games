extends Node

var open = false

var slots = {}
var weapon_slot: WeaponItem

func reset():
	for key in slots:
		if slots[key] != null && is_instance_valid(slots[key]):
			slots[key].queue_free()
	slots = {}
	if weapon_slot != null && is_instance_valid(weapon_slot):
		weapon_slot.queue_free()
	weapon_slot = null
	
func load_save_data(data):
	if data["weapon"] != null:
		var weapon_scene: String = data["weapon"]
		weapon_slot = load(weapon_scene).instance()

	var inv_save_slots = data["slots"]
	for slot_key in inv_save_slots:
		if inv_save_slots[slot_key].item != null:
			var item = load(inv_save_slots[slot_key].item).instance()
			item.set_quantity(inv_save_slots[slot_key].quantity)
			slots[slot_key] = item

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
