extends Area2D

# todo - delete all of this
var moving = []

func _process(delta):
#	for player in moving:
#		player.motion.x -= 50
	pass
	

func _on_ConveyorBelt_body_entered(body):
	if body.is_in_group("players"):
		moving.push_back(body)
	pass
	


func _on_ConveyorBelt_body_exited(body):
	if body.is_in_group("players"):
		moving.remove(moving.find(body))
	pass
