extends Node2D

enum SFX_ID {
	BtnSelect,
	BtnPress,
	BtnBack,
	PlayerAttack,
	HitTaken,
	Interact,
	FoorStep
}


func play(sfx):
	match sfx:
		SFX_ID.BtnPress:
			get_node("BtnPress").play()
		SFX_ID.BtnSelect:
			get_node("BtnSelect").play()
		SFX_ID.BtnBack:
			get_node("BtnBack").play()
		SFX_ID.PlayerAttack:
			get_node("PlayerAttack").play()
		SFX_ID.HitTaken:
			get_node("HitTaken").play()
		SFX_ID.Interact:
			get_node("Interact").play()
		SFX_ID.FoorStep:
			get_node("FoorStep").play()
			
