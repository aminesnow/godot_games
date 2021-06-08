extends Control

onready var heartsFull = $HeartFull
onready var heartsEmpty = $HeartEmpty
const HEART_SIZE = 15

var hearts = 5 setget set_hearts
var max_hearts = 5 setget set_max_hearts


func set_hearts(value):
	hearts = value
	heartsFull.rect_size.x = hearts * HEART_SIZE

func set_max_hearts(value):
	max_hearts = value
	self.set_hearts(min(max_hearts, hearts))
	heartsEmpty.rect_size.x = value * HEART_SIZE

func _ready():
	self.hearts = PlayerStats.health
	self.max_hearts = PlayerStats.max_health
	heartsFull.rect_size.x = self.hearts * HEART_SIZE
	heartsEmpty.rect_size.x = self.max_hearts * HEART_SIZE
	GameEvents.connect("PlayerHealthChanged", self, "set_hearts")
	GameEvents.connect("PlayerMaxHealthChanged", self, "set_max_hearts")
