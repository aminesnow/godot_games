extends Slot

func init_slot():
	if PlayerInventory.weapon_slot != null:
		item = PlayerInventory.weapon_slot
		item.position = Vector2(0, 0)
		item.set_quantity(0)
		add_child(item)

func pickFromSlot():
	.pickFromSlot()
	update_inventory()
	
func putIntoSlot(new_item: Item):
	if new_item.category == Item.CATEGORY_Weapon:
		.putIntoSlot(new_item)
		update_inventory()
	else:
		print("wrong item category")

func process_click(event: InputEventMouseButton):
	if uiNode.holding_item != null and uiNode.holding_item.category != Item.CATEGORY_Weapon:
		pass
	else:
		.process_click(event)

func update_inventory():
	PlayerInventory.weapon_slot = item
	GameEvents.emit_signal("WeaponEquiped")
