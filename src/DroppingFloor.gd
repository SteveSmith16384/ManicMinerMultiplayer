extends StaticBody2D

var start_y : int
var bodies = []
var time_to_raise : float

const SPEED : int = 25

func _ready():
	start_y = self.position.y
	pass
	
	
func _process(delta):
	if bodies.size() > 0:
		time_to_raise = 0
#		if self.position.y < start_y + $Sprite.texture.get_height() * 2:
		self.position.y += delta * SPEED
	else:
		time_to_raise += delta
		if time_to_raise > 5:
			if position.y > start_y:
				self.position.y -= delta * (SPEED/2)
	pass
	
	
func _on_Area2D_Dropping_body_entered(body):
#	if body.is_in_group("players"):
#		bodies.push_back(body)
	pass


func _on_Area2D_Dropping_body_exited(body):
#	if body.is_in_group("players"):
#		bodies.remove(bodies.find(body))
	pass


func _on_Area2D_Dropping_area_entered(area):
	if area.is_in_group("feet"):
		bodies.push_back(area)
	pass # Replace with function body.


func _on_Area2D_Dropping_area_exited(area):
	if area.is_in_group("feet"):
		bodies.remove(bodies.find(area))
	pass # Replace with function body.
