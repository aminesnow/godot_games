class_name Interactable
extends Area2D

export(NodePath) var iteractableObjPath
export(String) var id

var can_interact = false
var iteractableObj: Node2D

func _process(_delta):
	if can_interact and Input.is_action_just_pressed("interact"):
		iteractableObj = get_node(iteractableObjPath)
		if iteractableObj.has_method("interact"):
			iteractableObj.interact()


func _on_Interactable_area_entered(_area):
	can_interact = true


func _on_Interactable_area_exited(_area):
	can_interact = false
	if iteractableObj and iteractableObj.has_method("stop_interact"):
			iteractableObj.stop_interact()
