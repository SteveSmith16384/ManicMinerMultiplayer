extends KinematicBody2D

export var LeftPos : NodePath
export var RightPos : NodePath

var max_left : Position2D
var max_right : Position2D

var dir = Vector2(-1, 0)

func _ready():
	$AnimationPlayer.play("Walk_Left")
	max_left = get_node(LeftPos)
	max_right = get_node(RightPos)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(dir * 50, Vector2.UP)
	if self.position.x < max_left.position.x:
		dir = dir * -1
		self.position.x = max_left.position.x
		$AnimationPlayer.play("Walk_Right")
		$YellowRobot_Left.visible = false
		$YellowRobot_Right.visible = true
	elif self.position.x > max_right.position.x:
		dir = dir * -1
		self.position.x = max_right.position.x
		$AnimationPlayer.play("Walk_Left")
		$YellowRobot_Left.visible = true
		$YellowRobot_Right.visible = false
	pass
