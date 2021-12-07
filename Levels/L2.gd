extends AbstractLevel


func _ready():
	self.player = $YSort/Player
	.ready()
	GameEvents.emit_signal("L2Ready")
