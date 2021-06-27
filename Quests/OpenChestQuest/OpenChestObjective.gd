extends AbstractObjective

export(String) var target_chest

func _ready():
	GameEvents.connect("OpenContainer", self, "check_chest")

func check_chest(container_id, _items):
	if started && !completed && container_id == target_chest:
		complete()
		GameEvents.disconnect("OpenContainer", self, "check_chest")
