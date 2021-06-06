extends KinematicBody2D


export var ACC = 500
export var MAX_SPEED = 80
export var FRICTION = 500

enum {
	IDLE,
	MOVE,
	ATTACK
}

signal PlayerDead
signal PlayerReady

onready var stats = PlayerStats
onready var sceneChanger = SceneChanger
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHB = $HitboxPivot/SwordHitBox
onready var hurtBox = $HurtBox
onready var interactorPivot = $InteractorPivot
onready var PlayerHurtSFX = preload("res://Effects/PlayerHurtSFX.tscn")

var velocity = Vector2.ZERO
var state = IDLE
var init_pose = null

func _ready():
	var levelGates = get_tree().get_nodes_in_group("LevelGates")
	for obj in levelGates:
		var gate: LevelGate = obj
		if gate.gateID == sceneChanger.gateID:
			yield(obj, "ready")
			global_position = gate.playerPosition.global_position
			init_pose = gate.playerPose
			break
	animationTree.active = true
	swordHB.knockBackVector = Vector2.LEFT
	stats.connect("Dead", self, "player_dead")


func player_dead():
	emit_signal("PlayerDead")
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
	init_player_pose()
	var input_vector = get_input_vector()
	if input_vector != Vector2.ZERO:
		init_pose = null
		state = MOVE

func attack():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func attack_finished():
	state = MOVE

func move(delta):
	var input_vector = get_input_vector()
	
	if input_vector != Vector2.ZERO:
		swordHB.knockBackVector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(MAX_SPEED * input_vector, ACC * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(input_vector, FRICTION * delta)

	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func init_player_pose():
	if init_pose != null:
		match init_pose:
			Commons.PlayerPose.DOWN:
				animationPlayer.play("IdleDown")

			Commons.PlayerPose.UP:
				animationPlayer.play("IdleUp")

			Commons.PlayerPose.LEFT:
				animationPlayer.play("IdleLeft")

			Commons.PlayerPose.RIGHT:
				animationPlayer.play("IdleRight")
		emit_signal("PlayerReady")

func _on_HurtBox_area_entered(area):
	stats.take_damage(area.damage)
	get_tree().current_scene.add_child(PlayerHurtSFX.instance())
	hurtBox.activate_invicibility()

func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		interactorPivot.rotation_degrees = fmod(rad2deg(input_vector.angle())-180, 360)
	return input_vector
