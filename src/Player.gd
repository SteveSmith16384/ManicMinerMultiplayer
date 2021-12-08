extends KinematicBody2D

#const MAX_SPEED_WALK_X = 5000/50
const SPEED = 100
#const MAX_SPEED_Y = 200
const GRAVITY = 5#4#0
const JUMP_FORCE = 150#60#50

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
var lives : int = 1
var out_of_game = false

func _ready():
	$AudioStreamPlayer_Pickup.stream = load("res://assets/sfx/sfx_movement_portal" + str(side+1) + ".wav")
	main.update_score(side, score, lives)
	pass
	
	
func _process(_delta):
	if invincible:
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
			motion.y -= JUMP_FORCE
		
	motion.x = 0
	if Input.is_action_pressed("move_right" + str(side)):
		motion.x = SPEED
		animationPlayer.play("Run_Right")
	elif Input.is_action_pressed("move_left" + str(side)):
		motion.x = -SPEED
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
		if coll.collider.is_in_group("players"):
			var enemy = coll.collider
			if enemy.alive:
				if enemy.position.y < position.y:
					self.die()
				else:
					enemy.die()
					
	pass


func _on_FloorArea2D_body_entered(body):
	if body.is_in_group("floors"):
		is_on_floor = true
		$AudioStreamPlayer_Landed.play()
	pass


func _on_FloorArea2D_body_exited(body):
	if body.is_in_group("floors"):
		is_on_floor = false
		main.show_explosion(self)
		$AudioStreamPlayer_Jump.play()
	pass


func _on_InvincibleTimer_timeout():
	invincible = false
	pass


func die():
	if invincible:
		return
		
	lives -= 1
	$AudioStreamPlayer_Died.play()
	self.position = Vector2(-1000, -1000)
	alive = false
	main.show_explosion(self)
	if lives >= 0:
		$RespawnTimer.start()
	else:
		out_of_game = true
		main.check_for_winner()
	main.update_score(side, score, lives)
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
	main.update_score(side, score, lives)
	pass
	
	
