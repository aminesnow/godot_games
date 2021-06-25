extends PanelContainer

onready var title = $MarginContainer/VBoxContainer/Title
onready var desc = $MarginContainer/VBoxContainer/Description

func set_title(text: String):
	title.set_text(text)

func set_description(text: String):
	desc.set_text(text)
