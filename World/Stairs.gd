extends StaticBody2D

signal TurnOffCliffColis(body)
signal TurnOnClifColis(body)

func _on_Area2D_body_entered(body):
	emit_signal("TurnOffCliffColis", body)


func _on_Area2D_body_exited(body):
	emit_signal("TurnOnClifColis", body)
