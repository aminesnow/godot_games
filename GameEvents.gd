extends Node

signal SceneChanged
signal PlayerDead
signal ChangeScene(gateID, targetLevel)
signal BatWanderTimeOut(wanderCtrl)
signal OutOfHealth(obj)
signal PlayerHealthChanged(health)
signal PlayerMaxHealthChanged(health)
signal TurnOffCliffColis(body)
signal TurnOnClifColis(body)
signal SlotClicked(slot)
signal OpenInventory
signal CloseInventory
signal OpenContainer(containerItems)
signal CloseContainer
signal WeaponEquiped
signal ShowSlotPopup(item)
signal HideSlotPopup

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


