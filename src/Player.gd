class_name Player
extends KinematicBody2D

const SPEED = 80
const GRAVITY = 5
const JUMP_FORCE = 150

onready var main = get_tree().get_root().get_node("World")

onready var walking_left_sprite = $WalkingLeftSprites
onready var walking_right_sprite = $WalkingRightSprites
onready var animationPlayer = $AnimationPlayer

var motion = Vector2.ZERO
var last_dir : int = 1 # -1 or 1
var invincible = true
var alive = true
var side : int
var is_on_floor = false
var score : int = 0
var on_conveyor = false
var keys_collected : int = 0

func _ready():
	main.update_score(self)
	pass
	
	
func _process(_delta):
	if keys_collected >= main.total_keys:
		self.visible = not self.visible
	else:
		self.visible = true
	pass
	
	
func _physics_process(_delta):
	if alive == false:
		return
		
	if main.game_over:
		return
		
	motion.y += GRAVITY
	if Input.is_action_pressed("jump"+str(side)):
		if is_on_floor():
			$AudioStreamPlayer_Jump.play()
			motion.y -= JUMP_FORCE
		
	motion.x = 0
	if on_conveyor:
		motion.x -= 50
	if Input.is_action_pressed("move_right" + str(side)):
		motion.x += SPEED
		animationPlayer.play("Run_Right")
	elif Input.is_action_pressed("move_left" + str(side)):
		motion.x -= SPEED
		animationPlayer.play("Run_Left")
	else:
		animationPlayer.stop(false)
	
	if motion.x != 0:
		last_dir = sign(motion.x)
		
	if last_dir < 0:
		walking_left_sprite.visible = true
		walking_right_sprite.visible = false
	else:
		walking_left_sprite.visible = false
		walking_right_sprite.visible = true
			
	motion = move_and_slide(motion, Vector2.UP)
	
	var c = get_slide_count()
	for i in range (c):
		var coll = get_slide_collision(i)
		if coll.collider.is_in_group("kills_player"):
			self.die()
	pass


func _on_InvincibleTimer_timeout():
	invincible = false
	pass


func die():
	if invincible:
		return
		
	$AudioStreamPlayer_Died.play()
	self.position = Vector2(-1000, -1000)
	alive = false
	$RespawnTimer.start()
	main.update_score(self)
	pass
	

func _on_RespawnTimer_timeout():
	alive = true
	invincible = true
	motion = Vector2()
	main.set_player_start_pos(self)
	$InvincibleTimer.start()
	pass


func inc_score(amt):
	score += amt
	main.update_score(self)
	pass
	

func _on_FloorArea2D_area_entered(area):
	if area.is_in_group("conveyors"):
		on_conveyor = true
	pass


func _on_FloorArea2D_area_exited(area):
	if area.is_in_group("conveyors"):
		on_conveyor = false
	pass

