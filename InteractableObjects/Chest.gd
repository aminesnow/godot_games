extends Node2D

export(PackedScene) var slot0
export(int) var stack0 = 1

export(PackedScene) var slot1
export(int) var stack1 = 1

export(PackedScene) var slot2
export(int) var stack2 = 1

onready var animatedSprite: AnimatedSprite = $AnimatedSprite
onready var interactable = $Interactable

var id: String
var open = false
var items = null

func _ready():
	id = $Interactable.id
	if is_open():
		animatedSprite.frame = 1
	items = get_items()

func interact(_interactor):
	if !is_open():
		get_tree().paused = true
		open = true
		animatedSprite.play("open")
		GameEvents.emit_signal("OpenContainer", id, items)
		GameEvents.connect("CloseInventory", self, "interact")
	else:
		stop_interact()

func get_items():
	if items == null:
		items= {}
		if ContainersInventory.containers_slot.has(id):
			items = ContainersInventory.containers_slot[id]
		else:
			var slots = [
				{"idx": 0, "slot": slot0, "quant": stack0}, 
				{"idx": 1, "slot": slot1, "quant": stack1}, 
				{"idx": 2, "slot": slot2, "quant": stack2}
			]

			for slot in slots:
				if slot["slot"] != null:
					var item = slot["slot"].instance()
					item.set_quantity(slot["quant"])
					items[slot["idx"]] = item

			ContainersInventory.containers_slot[id] = items
	return items

func stop_interact():
	if is_open():
		get_tree().paused = false
		GameEvents.emit_signal("CloseContainer")
		GameEvents.emit_signal("HideSlotPopup")
		GameEvents.disconnect("CloseInventory", self, "interact")
		animatedSprite.play("open", true)
		open = false

func is_open() -> bool:
	return open
