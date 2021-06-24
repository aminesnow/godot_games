extends Node

signal SceneChanged
signal PlayerDead
signal ChangeScene(gateID, targetLevel)
signal BatWanderTimeOut(wanderCtrl)
signal OutOfHealth(obj)
signal PlayerHealthChanged(health)
signal PlayerMaxHealthChanged(health)
signal TurnOffCliffColis(body)
signal TurnOnClifColis(body)
signal SlotClicked(slot)
signal OpenInventory
signal CloseInventory
signal OpenContainer(containerItems)
signal CloseContainer
signal WeaponEquiped
signal ShowSlotPopup(item)
signal HideSlotPopup
signal PauseGame
signal UnPauseGame
signal QuestComplete(quest)
signal CloseAll
signal Talking(npc)
