class_name WeaponItem
extends Item

var damage = 0

func init_values():
	.init_values()
	damage = JsonData.item_data[label]["Attack"]
