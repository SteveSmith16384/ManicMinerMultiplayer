extends StaticBody2D

const SPEED : int = 25

var start_y : int
var bodies = []
var time_to_raise : float

const drop_height = 16

func _ready():
	start_y = self.position.y
	pass
	
	
func _process_OLD(delta):
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
	
	
func _process(delta):
	if bodies.size() > 0:
		time_to_raise = 0
		$Sprite.position.y += delta * SPEED
		adjust_body()
	else:
		time_to_raise += delta
		if time_to_raise > 5:
			if $Sprite.position.y > 0:
				$Sprite.position.y -= delta * (SPEED/2)
				adjust_body()
	pass
	

func adjust_body():
	if self.position.y < start_y:
		self.position.y = start_y
		$Sprite.position.y = 0
		return
	
	if $Sprite.position.y > drop_height:
		self.position.y += drop_height
		$Sprite.position.y -= drop_height
	elif $Sprite.position.y < 0:
		self.position.y -= drop_height
		$Sprite.position.y += drop_height
	pass
	
	
func _on_Area2D_Dropping_area_entered(area):
	if area.is_in_group("feet"):
		bodies.push_back(area)
	pass 


func _on_Area2D_Dropping_area_exited(area):
	if area.is_in_group("feet"):
		bodies.remove(bodies.find(area))
	pass
