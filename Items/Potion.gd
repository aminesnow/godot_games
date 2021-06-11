extends ConsumableItem


func _ready():
	print("_ready")
	init_values()


func init_values():
	label = "Health Potion"
	.init_values()
	print(label)
