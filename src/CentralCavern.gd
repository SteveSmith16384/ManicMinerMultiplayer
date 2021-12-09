extends Node2D



func _on_Area2D_Deadly_body_entered(body):
	if body.is_in_group("players"):
		body.die();
	pass


func _on_Area2D_Conveyor_body_entered(body):
	if body.is_in_group("players"):
		body.position.x -= 1
	pass
