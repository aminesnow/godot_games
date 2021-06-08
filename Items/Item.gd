class_name Item
extends Node2D

var label
var quantity
var stack_size: int


func ready():
	stack_size = int(JsonData.item_data[label]["StackSize"])
	
	quantity = randi() % stack_size + 1

	if quantity <= 1:
		$Label.visible = false
	else:
		$Label.text = String(quantity)

func add_quantity(quant):
	var sum = quantity + quant
	if sum >= 0 and sum <= stack_size:
		quantity = sum
		$Label.text = String(quantity)
