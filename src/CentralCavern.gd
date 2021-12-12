extends Node2D


func _on_Area2D_Deadly_body_entered(body):
	if body.is_in_group("players"):
		body.die();
	pass


func show_toaster():
	$Toaster/Toaster_Flashing.show()
	pass
	
