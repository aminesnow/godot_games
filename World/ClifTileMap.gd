extends TileMap

func _ready():
	GameEvents.connect("TurnOffCliffColis", self, "TurnOffCliffColis")
	GameEvents.connect("TurnOnClifColis", self, "TurnOnClifColis")

func TurnOffCliffColis(body):
	body.set_collision_layer_bit(6, false)

func TurnOnClifColis(body):
	body.set_collision_layer_bit(6, true)
