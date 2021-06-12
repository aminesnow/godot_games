extends Popup

onready var itemName = $NinePatchRect/MarginContainer/VBoxContainer/ItemName
onready var itemDesc = $NinePatchRect/MarginContainer/VBoxContainer/ItemDesc
onready var stat1 = $NinePatchRect/MarginContainer/VBoxContainer/Stat1
onready var stat2 = $NinePatchRect/MarginContainer/VBoxContainer/Stat2
onready var stat3 = $NinePatchRect/MarginContainer/VBoxContainer/Stat3

func _ready():
	GameEvents.connect("ShowSlotPopup", self, "show_info")
	GameEvents.connect("HideSlotPopup", self, "hide_info")


func show_info(item: Item):
	if item != null:
		rect_position = get_global_mouse_position()
		itemName.bbcode_text = "[center][u][b][color=black]" + item.label + "[/color][/b][/u][/center]"
		itemDesc.text = item.description
		var stats = [stat1, stat2, stat3]
		for i in item.stats.size():
			stats[i].text = item.stats[i]
		show()

func hide_info():
	hide()

func _input(_event):
	if is_visible():
		rect_position = get_global_mouse_position()
