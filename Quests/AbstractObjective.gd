class_name AbstractObjective
extends Node


signal completed(obj)
signal failed(obj)

export(String) var id

var started: bool = false
var completed: bool = false
var failed: bool = false

func get_save_data():
	return {
		"started": started,
		"completed": completed,
		"failed": failed,
	}

func load_save_data(data):
	started = data["started"]
	completed = data["completed"]
	failed = data["failed"]

func reset():
	started = false
	completed = false
	failed = false

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
