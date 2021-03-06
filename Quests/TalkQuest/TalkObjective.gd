extends AbstractObjective

export(PackedScene) var target_npc


func _ready():
	GameEvents.connect("Talking", self, "check_talk")

func reset():
	.reset()
	_ready()

func check_talk(npc: Node2D):
	if started && !completed && npc.filename == target_npc.resource_path:
		complete()
		GameEvents.disconnect("Talking", self, "check_talk")
