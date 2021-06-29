extends Control


enum TYPE {
	SAVE,
	LOAD
}

export(TYPE) var type

const SAVE_DIR = "user://saves/"
const SAVE_FILE = SAVE_DIR + "save_{idx}.dat"
const ENCRYPT_KEY = "azerty"

onready var saveSlots =  $NinePatchRect/MarginContainer/SaveSlots

export(PackedScene) var startScene

func _ready():
	get_saves()

func get_saves():
	var file = File.new()
	for i in range(3):
		if file.file_exists(_get_save_path(i)):
			saveSlots.get_child(i).set_label("Save " + str(i+1))

func process_click(idx):
	match type:
		TYPE.SAVE:
			save(idx)
		TYPE.LOAD:
			load_save(idx)

func save(idx):
	var save_data = {
		"objects": {}
	}
	var nodes = get_tree().get_nodes_in_group("save")
	for node in nodes:
		save_data["objects"][node.get_path()] = node.get_save_data()
	save_data["player_inventory"] = PlayerInventory.get_save_data()
	save_data["containers_slots"] = ContainersInventory.get_save_data()
	save_data["currents_level"] = get_tree().get_nodes_in_group("levels")[0].get_child(0).filename
	print(save_data)
	
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR) 
	
	var file = File.new()
	print(_get_save_path(idx))
	var err = file.open_encrypted_with_pass(_get_save_path(idx), File.WRITE, ENCRYPT_KEY)
	if err != OK:
		print(err)
		return
	file.store_var(save_data)
	file.close()
	get_saves()


func load_save(idx):
	var file = File.new()
	if file.file_exists(_get_save_path(idx)):
		var err = file.open_encrypted_with_pass(_get_save_path(idx), File.READ, ENCRYPT_KEY)
		if err != OK:
			print(err)
			return
		var data = file.get_var()
		file.close()
		
		print(data)
		PlayerInventory.load_save_data(data)
		ContainersInventory.load_save_data(data)
		
		var staring_point = startScene.instance()
		staring_point.startLevelPath = data["currents_level"]
		staring_point.visible = false
		print("loading save")
		get_tree().get_root().add_child(staring_point)
		
		for obj_path in data["objects"]:
			var obj = staring_point.get_node(obj_path)
			if obj != null:
				obj.load_save_data(data["objects"][obj_path])
		
		staring_point.visible = true
		find_parent("StartMenu").queue_free()


func _get_save_path(idx):
	return SAVE_FILE.format({"idx": idx})

func _on_Slot1_pressed():
	process_click(0)


func _on_Slot2_pressed():
	process_click(1)


func _on_Slot3_pressed():
	process_click(2)

