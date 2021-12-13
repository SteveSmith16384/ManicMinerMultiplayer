extends Area2D


func show():
	self.visible = true
	$Timer.start()
	pass
	
	
func _on_Timer_timeout():
	self.visible = not self.visible
	pass


func _on_Toaster_body_entered(body):
#	if self.visible == false:
#		return
		
	if body.is_in_group("players"):
		var main = get_tree().get_root().get_node("World")
		if body.keys_collected >= main.total_keys:
			main.show_winner(body.side)
	pass
