class_name Item
extends Node2D

var label: String
var description: String
var quantity = 0
var stack_size: int
var category: String
var stats = []

const CATEGORY_Weapon = "Weapon"
const CATEGORY_Consumable = "Consumable"

func init_values():
	stack_size = int(JsonData.item_data[label]["StackSize"])
	category = JsonData.item_data[label]["Category"]
	description = JsonData.item_data[label]["Description"]
	if JsonData.item_data[label].has("Attack"):
		stats.push_back("- Attack: " + str(JsonData.item_data[label]["Attack"]))
	if JsonData.item_data[label].has("AddHealth"):
		stats.push_back("- Health: +" + str(JsonData.item_data[label]["AddHealth"]))

func set_quantity(amount):
	quantity = amount
	if quantity <= 1:
		$Label.visible = false
	else:
		$Label.text = String(quantity)

func add_quantity(quant):
	var sum = quantity + quant
	if sum >= 0 and sum <= stack_size:
		quantity = sum
		if quantity <= 1:
			$Label.visible = false
		else:
			$Label.text = String(quantity)

func get_texture() -> Texture:
	return $TextureRect.texture
