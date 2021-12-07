extends Node


var interactables_states = {}

func load_save_data():
	#TODO
	pass

func get_state(id: String):
	if interactables_states.has(id):
		return interactables_states[id]
	return null

func get_state_attr(id: String, attr: String):
	if interactables_states.has(id) and interactables_states[id].has(attr):
		return interactables_states[id][attr]
	return null

func set_state(id: String, state: Dictionary):
	assert(!interactables_states.has(id))
	interactables_states[id] = state

func set_state_attr(id: String, attr: String, value):
	if interactables_states.has(id):
		interactables_states[id][attr] = value
	else:
		interactables_states[id] = {
			attr: value
		}
