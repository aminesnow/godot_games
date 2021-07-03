extends AbstractStats

func reset():
	set_max_health(5)

func _ready():
	set_max_health(5)

func change_max_health(new_health):
	set_max_health(new_health)
	GameEvents.emit_signal("PlayerMaxHealthChanged", max_health)

func take_damage(damage, obj):
	.take_damage(damage, obj)
	GameEvents.emit_signal("PlayerHealthChanged", health)

func add_health(amount):
	.add_health(amount)
	GameEvents.emit_signal("PlayerHealthChanged", health)
