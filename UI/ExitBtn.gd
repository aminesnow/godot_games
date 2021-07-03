extends TextureButton



var press_sfx = Sfx.SFX_ID.BtnBack

func _ready():
	self.connect("pressed", self, "_on_Start_pressed")


func _on_Start_pressed():
	Sfx.play(press_sfx)
