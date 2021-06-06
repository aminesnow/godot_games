extends Area2D


const HitEffect = preload("res://Effects/HitEffect.tscn")

export var hit_effect_offset = Vector2.ZERO
export var invicibleTime = 0.0


func activate_invicibility():
	set_deferred("monitoring", false)
	yield(get_tree().create_timer(invicibleTime), "timeout")
	set_deferred("monitoring", true)

func _on_HurtBox_area_entered(_area):
	var he = HitEffect.instance()
	get_tree().current_scene.add_child(he)
	he.global_position = global_position - hit_effect_offset

