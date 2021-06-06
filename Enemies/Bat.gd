extends KinematicBody2D

enum {
	IDLE,
	WANDER,
	CHASE
}

export var ACCELERATION = 300
export var MAX_SPEED = 70
export var FRICTION = 200

const BAT_KB = 120
const DeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
var TIMER_DURATION = rand_range(1, 3)

var knockback = Vector2.ZERO
var state = IDLE
var velocity = Vector2.ZERO

onready var stats = $Stats
onready var playerDZ = $PlayerDetectionZone
onready var sprite = $AnimatedSprite
onready var hurtBox = $HurtBox
onready var wanderCtrl = $WanderCtrl

func _ready():
	var numFrames = sprite.frames.get_frame_count("BatAnimationFly")
	sprite.frame = randi() % numFrames
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()

		WANDER:
			seek_player()
			accelerate_to(wanderCtrl.target_position, delta)
			if global_position.distance_to(wanderCtrl.target_position) <= 4:
				state = pick_random_state([IDLE, WANDER])
				wanderCtrl.start_wander_timer(TIMER_DURATION)

		CHASE:
			if playerDZ.can_see_player():
				accelerate_to(playerDZ.player.global_position, delta)
			else:
				state = WANDER
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDZ.can_see_player():
		state = CHASE
		

func accelerate_to(target, delta):
	var direction = global_position.direction_to(target)
	velocity = velocity.move_toward(direction * MAX_SPEED, delta * ACCELERATION)
	sprite.flip_h = (velocity.x < 0)

func _on_HurtBox_area_entered(area):
	knockback = area.knockBackVector * BAT_KB
	stats.take_damage(area.damage)


func _on_Stats_Dead():
	var de = DeathEffect.instance()
	get_parent().add_child(de)
	de.position = self.position
	queue_free()

func pick_random_state(state_list: Array):
	state_list.shuffle()
	return state_list.pop_front()

func _on_WanderCtrl_TimeOut():
	state = pick_random_state([IDLE, WANDER])
	wanderCtrl.start_wander_timer(TIMER_DURATION)
	
