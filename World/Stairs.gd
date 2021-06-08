extends StaticBody2D


func _on_Area2D_body_entered(body):
	GameEvents.emit_signal("TurnOffCliffColis", body)


func _on_Area2D_body_exited(body):
	GameEvents.emit_signal("TurnOnClifColis", body)
