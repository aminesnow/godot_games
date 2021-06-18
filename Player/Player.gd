class_name Player
extends KinematicBody2D


export var ACC = 500
export var MAX_SPEED = 80
export var FRICTION = 500

enum {
	IDLE,
	MOVE,
	ATTACK
}



onready var stats = PlayerStats
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var weaponHB = $HitboxPivot/SwordHitBox
onready var hurtBox = $HurtBox
onready var interactorPivot = $InteractorPivot
onready var PlayerHurtSFX = preload("res://Effects/PlayerHurtSFX.tscn")
onready var weapon = $Weapon

var velocity = Vector2.ZERO
var state = IDLE

func _ready():
	animationTree.active = true
	weaponHB.knockBackVector = Vector2.LEFT
	GameEvents.connect("OutOfHealth", self, "player_dead")
	GameEvents.connect("WeaponEquiped", self, "equipe_weapon")
	equipe_weapon()

func equipe_weapon():
	if PlayerInventory.weapon_slot != null:
		weapon.texture = PlayerInventory.weapon_slot.get_texture()
		weaponHB.damage = PlayerInventory.weapon_slot.damage

func player_dead(obj):
	if obj == self:
		GameEvents.emit_signal("PlayerDead")
		queue_free()

func _physics_process(delta):
	match state:
		IDLE:
			idle()
		MOVE:
			move(delta)
		ATTACK:
			attack()


func idle():
	var input_vector = get_input_vector()
	if input_vector != Vector2.ZERO:
		state = MOVE

func has_weapon():
	return PlayerInventory.weapon_slot != null

func attack():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func attack_finished():
	state = MOVE

func move(delta):
	var input_vector = get_input_vector()
	
	if input_vector != Vector2.ZERO:
		weaponHB.knockBackVector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(MAX_SPEED * input_vector, ACC * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(input_vector, FRICTION * delta)

	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack") and has_weapon():
		state = ATTACK

func init_player_pose(init_pose):
	var poseVector = Commons.PoseVecotrs[init_pose]
	animationTree.set("parameters/Idle/blend_position", poseVector)
	animationTree.set("parameters/Run/blend_position", poseVector)
	animationTree.set("parameters/Attack/blend_position", poseVector)

func get_save_data():
	var position = global_position
	var player_stats = stats.get_save_data()
	return {
		"position": position,
		"stats": player_stats
	}

func load_save_data(data):
	global_position = data["position"]
	stats.load_save_data(data["stats"])

func _on_HurtBox_area_entered(area):
	stats.take_damage(area.damage, self)
	print(get_tree().current_scene)
	get_tree().get_root().add_child(PlayerHurtSFX.instance())
	hurtBox.activate_invicibility()

func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		interactorPivot.rotation_degrees = fmod(rad2deg(input_vector.angle())-180, 360)
	return input_vector
