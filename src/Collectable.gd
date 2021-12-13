extends Area2D

func _ready():
	var main = get_tree().get_root().get_node("World")
	main.keys =+ 1
	pass
	
	
func _on_Collectable_body_entered(body):
	if body.is_in_group("players"):
		$AudioStreamPlayer_Collected.play()
		body.inc_score(Globals.PTS_FOR_DIAMOND)

		var main = get_tree().get_root().get_node("World")
		main.key_collected()
		
		self.queue_free()
	pass
