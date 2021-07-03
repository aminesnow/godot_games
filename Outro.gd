extends Control

export(String, FILE, "*.tscn") var nextScenePath

onready var animPlayer = $AnimationPlayer

var win = true

func _ready():
	init_text()
	$Label.percent_visible = 0
	animPlayer.play("Animate")
	yield(animPlayer, "animation_finished")
	yield(get_tree().create_timer(2), "timeout")
	if ResourceLoader.exists(nextScenePath):
		get_tree().change_scene(nextScenePath)

func init_text():
	if win:
		$Label.text = JsonData.texts_data["outro_win"]
	else:
		$Label.text = JsonData.texts_data["outro_lose"]
