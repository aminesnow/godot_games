extends Button


var select_sfx = Sfx.SFX_ID.BtnSelect
var press_sfx = Sfx.SFX_ID.BtnPress

func _ready():
	self.connect("focus_entered", self,"_on_Start_focus_entered")
	self.connect("pressed", self, "_on_Start_pressed")


func _on_Start_focus_entered():
	Sfx.play(select_sfx)


func _on_Start_pressed():
	Sfx.play(press_sfx)
