extends Node

enum PlayerPose {
	RIGHT=0,
	LEFT=1,
	UP=2,
	DOWN=3
}

var PoseVecotrs = {
	PlayerPose.RIGHT: Vector2(1, 0),
	PlayerPose.LEFT: Vector2(-1, 0),
	PlayerPose.UP: Vector2(0, -1),
	PlayerPose.DOWN: Vector2(0, 1)
}
