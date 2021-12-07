extends Node

enum PlayerPose {
	RIGHT=0,
	LEFT=1,
	UP=2,
	DOWN=3
}

var PoseVectors = {
	PlayerPose.RIGHT: Vector2(1, 0),
	PlayerPose.LEFT: Vector2(-1, 0),
	PlayerPose.UP: Vector2(0, -1),
	PlayerPose.DOWN: Vector2(0, 1)
}

var VectorPoses = {}

func _ready():
	for pose in PoseVectors:
		VectorPoses[PoseVectors[pose]] = pose


func position_to_pose(pos: Vector2):
	var abs_x = abs(pos.x)
	var abs_y = abs(pos.y)
	var pose_vect = Vector2.ZERO
	if abs_x < abs_y && abs_y != 0:
		pose_vect.y = pos.y/abs_y
	elif abs_x > abs_y && abs_x != 0:
		pose_vect.x = pos.x/abs_x
	
	if VectorPoses.has(pose_vect):
		return VectorPoses[pose_vect]
	else:
		null

func get_opposite_pose(pose):
	return VectorPoses[-1 * PoseVectors[pose]]
