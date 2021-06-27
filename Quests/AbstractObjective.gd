class_name AbstractObjective
extends Node


signal completed(obj)
signal failed(obj)

var started: bool = false
var completed: bool = false
var failed: bool = false


func start():
	if !completed:
		started = true

func complete():
	if started:
		completed = true
		emit_signal("completed", self)

func fail():
	if started:
		failed = true
		emit_signal("failed", self)

func _process(delta):
	if started && !completed:
		check_completed()

func check_completed():
	pass
