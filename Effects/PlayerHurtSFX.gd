extends AudioStreamPlayer

func _on_PlayerHurtSFX_finished():
	queue_free()
