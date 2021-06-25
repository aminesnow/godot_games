extends AbstractObjective

export(PackedScene) var target_npc


func _ready():
	GameEvents.connect("Talking", self, "check_talk")

func check_talk(npc: Node2D):
	if !completed && npc.filename == target_npc.resource_path:
		complete()
