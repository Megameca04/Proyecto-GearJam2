extends KinematicBody2D

var speed = 300
var jump_speed = 200

var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.x = 0
	
func get_input():
	
	var up = Input.is_action_just_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var left = Input.is_action_pressed("ui_left")
	var rigth = Input.is_action_pressed("ui_right")
	
	if up:
		velocity.y = -1
	
	if left:
		velocity.y = -1
	
	if rigth:
		velocity.x = 1
	
