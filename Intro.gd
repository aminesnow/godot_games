extends Control

export(PackedScene) var startScene

onready var animPlayer = $AnimationPlayer

var readDone = false
var start = false

func _ready():
	$Label.text = JsonData.texts_data["intro"]
	$Label.percent_visible = 0
	animPlayer.play("Animate")

func _process(_delta):
	if !start && Input.is_action_just_pressed("ui_accept"):
		if readDone:
			start = true
			animPlayer.play("Fade")
			yield(animPlayer, "animation_finished")
			get_tree().change_scene_to(startScene)
		else:
			animPlayer.stop()
			readDone = true
			$Label.percent_visible = 1


func _on_AnimationPlayer_animation_finished(_anim_name):
	readDone = true
