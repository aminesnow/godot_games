extends ConsumableItem


func _ready():
	init_values()


func init_values():
	label = "Health Potion"
	.init_values()

func consume():
	PlayerStats.add_health(health)
	.consume()
