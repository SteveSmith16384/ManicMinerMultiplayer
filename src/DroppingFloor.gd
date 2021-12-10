extends StaticBody2D

var start_y : int

func _ready():
	start_y = self.position.y
	pass
	
	
	
func _on_Area2D_Dropping_body_entered(body):
	if body.is_in_group("players"):
		self.position.y += 1
		if self.position.y > start_y + $Sprite.texture.get_height() * 2:
			self.queue_free()
	pass
