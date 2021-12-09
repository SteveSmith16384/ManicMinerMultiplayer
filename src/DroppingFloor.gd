extends StaticBody2D



func _on_Area2D_Dropping_body_entered(body):
	if body.is_in_group("players"):
		self.position.y += 1
	pass
