extends Node

var item_data: Dictionary = {}

func _ready():
	item_data = LoadData("res://Data/ItemData.json")

func LoadData(path):
	var data
	var file = File.new()
	
	file.open(path, File.READ)
	data = JSON.parse(file.get_as_text())
	file.close()
	
	return data.result
