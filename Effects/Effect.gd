extends AnimatedSprite

export var time_to_disapear = 0.5

func _ready():
	connect("animation_finished", self, "_on_AnimatedSprite_animation_finished")
	play("Animate")



func _on_AnimatedSprite_animation_finished():
	yield(get_tree().create_timer(time_to_disapear), "timeout")
	queue_free()
