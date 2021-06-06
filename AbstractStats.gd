class_name AbstractStats
extends Node


export var max_health = 1 setget set_max_health
onready var health = max_health

signal Dead
signal HealthChanged(health)
signal MaxHealthChanged(health)

func set_max_health(new_health):
	max_health = new_health
	health = min(new_health, max_health)
	emit_signal("MaxHealthChanged", health)

func take_damage(damage):
	health = clamp(health - damage, 0, max_health)
	emit_signal("HealthChanged", health)
	if health <= 0:
		emit_signal("Dead")
