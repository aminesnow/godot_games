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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


