extends Area2D


func _on_Timer_timeout():
	self.visible = not self.visible
	pass


func _on_Toaster_body_entered(body):
	if body.is_in_group("players"):
		var main = get_tree().get_root().get_node("World")
		main.show_winner(body.side)
	pass
