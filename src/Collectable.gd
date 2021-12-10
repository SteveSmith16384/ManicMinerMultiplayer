extends Area2D


func _on_Collectable_body_entered(body):
	if body.is_in_group("players"):
		body.inc_score(Globals.PTS_FOR_DIAMOND)
		self.queue_free()
	pass
