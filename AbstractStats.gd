class_name AbstractStats
extends Node


export var max_health = 1 setget set_max_health
onready var health = max_health


func set_max_health(new_health):
	max_health = new_health
	health = min(new_health, max_health)


func change_max_health(new_health):
	set_max_health(new_health)

func take_damage(damage, obj):
	health = clamp(health - damage, 0, max_health)
	if health <= 0:
		out_of_health(obj)

func out_of_health(obj):
	GameEvents.emit_signal("OutOfHealth", obj)
