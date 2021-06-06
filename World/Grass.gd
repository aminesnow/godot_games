extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn") 

func create_grass_effect():
	var ge = GrassEffect.instance()
	get_parent().add_child(ge)
	ge.position = self.position




func _on_HurtBox_area_entered(area):
	create_grass_effect()
	queue_free()
