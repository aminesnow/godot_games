extends TileMap

func _ready():
	for stair in get_tree().get_nodes_in_group("Stairs"):
		stair.connect("TurnOffCliffColis", self, "TurnOffCliffColis")
		stair.connect("TurnOnClifColis", self, "TurnOnClifColis")

func TurnOffCliffColis(_body):
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(0, false)

func TurnOnClifColis(_body):
	set_collision_layer_bit(0, true)
	set_collision_mask_bit(0, true)
