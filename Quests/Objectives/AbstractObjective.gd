extends Node


signal completed(obj)

var started: bool = false
var completed: bool = false


func start():
	if !completed:
		started = true

func complete():
	if started:
		completed = true

func _process(delta):
	if started && !completed:
		check_completed()

func check_completed():
	pass
