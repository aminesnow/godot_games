extends AbstractObjective


export(PackedScene) var target_enemy
export(int) var max_attack_count

var attack_count = 0
var kill_count = 0
var bat_count

func _ready():
	GameEvents.connect("AttackedEnemy", self, "check_attack")
	GameEvents.connect("OutOfHealth", self, "enemy_killed")
	GameEvents.connect("LevelChanged", self, "load_bat_count")
	GameEvents.connect("L2Ready", self, "load_bat_count")

func get_save_data():
	var data = .get_save_data()
	data["attack_count"] = attack_count
	data["kill_count"] = kill_count
	
	return data

func load_save_data(data):
	.load_save_data(data)
	load_bat_count()
	attack_count = data["attack_count"]
	kill_count = data["kill_count"]

	
func reset():
	.reset()
	load_bat_count()
	GameEvents.connect("AttackedEnemy", self, "check_attack")
	attack_count = 0
	kill_count = 0

func load_bat_count():
	if bat_count == null:
		var bats = get_tree().get_nodes_in_group("bats")
		if bats and bats.size() > 0:
			bat_count = bats.size()

func enemy_killed(enemy: Node2D):
	if enemy.filename == target_enemy.resource_path:
		kill_count += 1

func check_attack(enemy: Node2D):
	if started && !completed && enemy.filename == target_enemy.resource_path:
		attack_count += 1

func check_completed():
	if !completed && !failed:
		if attack_count <= max_attack_count && kill_count == bat_count:
			print("objective completed: ", self.filename)
			complete()
			GameEvents.disconnect("AttackedEnemy", self, "check_attack")
		if attack_count >= max_attack_count && kill_count < bat_count:
			print("objective failed: ", self.filename)
			fail()
			GameEvents.disconnect("AttackedEnemy", self, "check_attack")
