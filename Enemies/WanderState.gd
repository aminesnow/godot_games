extends Node2D

export(int) var wander_range = 32

onready var start_position = global_position
onready var target_position = global_position
onready var timer = $Timer

func update_target_position():
	var rr = rand_range(-wander_range, wander_range)
	target_position = start_position + Vector2(rr, rr)

func start_wander_timer(duration):
	timer.start(duration)

func _on_Timer_timeout():
	update_target_position()
	GameEvents.emit_signal("BatWanderTimeOut", self)
