extends KinematicBody2D

var speed = 300
var jump_speed = 200
var weight = 500

var velocity = Vector2.ZERO

func _process(delta):
	attacks()

func _physics_process(delta):
	velocity.x = 0
	get_input()
	
	if !$AnimationPlayer.is_playing():
		if velocity.x != 0:
			$AnimatedSprite.animation = "move"
		else:
			$AnimatedSprite.animation = "default"
	velocity.y += weight * delta
	velocity = move_and_slide(velocity, Vector2(0,-1))

func get_input():
	
	var up = Input.is_action_just_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var left = Input.is_action_pressed("ui_left")
	var rigth = Input.is_action_pressed("ui_right")
	
	if up:
		velocity.y -= jump_speed
	
	if left:
		velocity.x -= speed
	
	if rigth:
		velocity.x += speed
	

func attacks():
	
	var z = Input.is_action_just_pressed("ui_z")
	
	if z:
		$AnimationPlayer.play("Punch")
