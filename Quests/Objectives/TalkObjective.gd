extends AbstractObjective

export(PackedScene) var target_npc


func _ready():
	GameEvents.connect("Talking", self, "check_talk")

func check_talk(npc: Node2D):
	print(npc.filename)
	print(npc.filename)
	if !completed && npc.filename == target_npc.filename:
		complete()
