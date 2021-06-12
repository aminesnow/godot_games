class_name ConsumableItem
extends Item

var health = 0

func init_values():
	.init_values()
	if JsonData.item_data[label].has("AddHealth"):
		health = JsonData.item_data[label]["AddHealth"]

func consume():
	set_quantity(quantity-1)
	if quantity == 0:
		queue_free()
