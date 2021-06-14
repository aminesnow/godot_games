extends Control


enum TYPE {
	SAVE,
	LOAD
}

export(TYPE) var type

func _ready():
	load_saves()

func load_saves():
	pass

func process_click(idx):
	match type:
		TYPE.SAVE:
			save(1)
		TYPE.LOAD:
			load_save(1)

func save(idx):
	var save_data = {}
	var nodes = get_tree().get_nodes_in_group("save")
	for node in nodes:
		save_data[node.filename] = node.get_save_data()
	save_data["player_inventory"] = PlayerInventory.get_save_data()
	save_data["containers_slots"] = ContainersInventory.get_save_data()
	save_data["currents_level"] = get_tree().get_nodes_in_group("levels")[0].get_child(0).filename
	print(save_data)


func load_save(idx):
	pass

func _on_Slot1_pressed():
	process_click(1)


func _on_Slot2_pressed():
	process_click(2)


func _on_Slot3_pressed():
	process_click(3)

