extends Node2D

onready var animatedSprite: AnimatedSprite = $AnimatedSprite
onready var interactable = $Interactable
var open = false

func _ready():
	if is_open():
		animatedSprite.frame = 1


func interact():
	if !is_open():
		open = true
		print("chest open")
		animatedSprite.play("open")
		GameEvents.emit_signal("OpenContainer")
		GameEvents.connect("CloseInventory", self, "interact")
		#InteractableGlobals.set_state_attr(interactable.id, "open", true)
	else:
		open = false
		stop_interact()

func stop_interact():
	GameEvents.emit_signal("CloseContainer")
	GameEvents.disconnect("CloseInventory", self, "interact")
	animatedSprite.play("open", true)

func is_open() -> bool:
	return open
