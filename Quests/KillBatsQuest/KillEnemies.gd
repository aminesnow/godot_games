extends AbstractObjective


export(PackedScene) var target_enemy
export(int) var max_attack_count

var attack_count = 0
var kill_count = 0
var bat_count

func _ready():
	GameEvents.connect("AttackedEnemy", self, "check_attack")
	GameEvents.connect("OutOfHealth", self, "killed")
	GameEvents.connect("LevelChanged", self, "on_level_changed")

func on_level_changed():
	if bat_count == null:
		var bats = get_tree().get_nodes_in_group("bats")
		if bats and bats.size() > 0:
			bat_count = bats.size()

func killed(enemy: Node2D):
	if enemy.filename == target_enemy.resource_path:
		kill_count += 1
		print("kill_coun: ", kill_count)
		print("bat_count: ", bat_count)

func check_attack(enemy: Node2D):
	if started && !completed && enemy.filename == target_enemy.resource_path:
		attack_count += 1
		print("attack_count: ", attack_count)
		print("max_attack_count: ", max_attack_count)

func check_completed():
	if !completed && !failed:
		if attack_count <= max_attack_count && kill_count == bat_count:
			print("completed")
			complete()
			GameEvents.disconnect("AttackedEnemy", self, "check_attack")
		if attack_count > max_attack_count && kill_count < bat_count:
			print("failed")
			fail()
			GameEvents.disconnect("AttackedEnemy", self, "check_attack")
