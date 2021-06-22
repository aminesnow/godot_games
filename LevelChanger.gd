extends CanvasLayer


onready var animation_player = $AnimationPlayer
onready var colorRect = $Control/ColorRect
onready var root: Node = get_parent()
onready var levels: Node = root.get_node("Levels")

var changingLevel = false

func _ready():
	GameEvents.connect("ChangeScene", self, "on_ChangeScene")

func on_ChangeScene(gateID, targetLevel):
	start_change_level(gateID, targetLevel)

func start_change_level(sourceGateID, targetScene: String, delay = 0.0):
	if !changingLevel:
		changingLevel = true
		yield(get_tree().create_timer(delay), "timeout")
		animation_player.play("Fade")
		yield(animation_player, "animation_finished")
		
		var old_level = levels.get_child(0)
		levels.remove_child(old_level)
		old_level.call_deferred("queue_free")

		# Add the next level
		var next_level_resource = load(targetScene)
		var next_level = next_level_resource.instance()
		levels.add_child(next_level)
		
		GameEvents.emit_signal("SceneChanged")

		# Set player position for next level
		var levelGates = get_tree().get_nodes_in_group("LevelGates")
		for obj in levelGates:
			var gate: LevelGate = obj
			if gate.gateID == sourceGateID:
				var player = levels.get_child(0).find_node("Player")
				player.global_position = gate.playerPosition.global_position
				player.set_player_pose(gate.playerPose)
				break

		finish_change_level(delay)


func finish_change_level(delay):
	if changingLevel:
		changingLevel = false
		yield(get_tree().create_timer(delay), "timeout")
		animation_player.play_backwards("Fade")
		yield(animation_player, "animation_finished")
