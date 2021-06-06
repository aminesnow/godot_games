extends Node2D

onready var animatedSprite = $AnimatedSprite
onready var interactable = $Interactable

func _ready():
	if chest_is_open():
		animatedSprite.frame = 1
		

func interact():
	if !chest_is_open():
		print("chest open")
		animatedSprite.play("open")
		InteractableGlobals.set_state_attr(interactable.id, "open", true)

func chest_is_open() -> bool:
	return InteractableGlobals.get_state_attr(interactable.id, "open") != null\
		and InteractableGlobals.get_state_attr(interactable.id, "open")
