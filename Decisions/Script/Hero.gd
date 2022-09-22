extends KinematicBody2D

export (bool) var activado

var speed = 300
var jump_speed = 400
var weight = 500

var rival = null

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var agresivity = 0
var move = true

var rgn = RandomNumberGenerator.new()
var distance


func _ready():
	$Salud.connect("depleted",self,"defeat")
	
	var rv = get_tree().get_nodes_in_group("Player")
	
	var i = 0
	while i < rv.size():
		
		if rv[i] != self:
			rival = rv[i]
			
		i += 1
	
	set_physics_process(false)
	set_process(false)
	
	distance = self.global_position.x - rival.global_position.x

func _process(delta):
	animations()
	

func _physics_process(delta):
	velocity.x = 0
	
	velocity.y += weight * delta
	
	
	if activado:
		get_input()
	else:
		ia_movement()
	
	velocity = move_and_slide(velocity + knockback, Vector2(0,-1))

func get_input():
	
	var up = Input.is_action_just_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var left = Input.is_action_pressed("ui_left")
	var rigth = Input.is_action_pressed("ui_right")
	
	if is_on_floor():
		if up:
			velocity.y -= jump_speed
	
	if left:
		velocity.x -= speed
	
	if rigth:
		velocity.x += speed
	

func animations():
	
	var z = Input.is_action_just_pressed("ui_z")
	
	if z and activado:
		$AnimationPlayer.play("Punch")
	
	if !$AnimationPlayer.is_playing():
		if velocity.x != 0:
			$AnimatedSprite.animation = "move"
		else:
			$AnimatedSprite.animation = "default"
		
	$AnimatedSprite.scale.x = 3*sign(self.global_position.x - rival.global_position.x)

func defeat():
	set_physics_process(false)
	set_process(false)
	$AnimationPlayer.play("Defeat")

func _on_Area_dano_area_entered(area):
	if area.name == "Area_ataque":
		knockback.x += sign(distance)*300
		$K_timer.start()
		$Salud.current -= 1
		if activado:
			$AnimatedSprite/Area_ataque/Area.disabled = true
			$AnimatedSprite/Area_ataque/Area.disabled = false
		
func ia_movement():
	distance = self.global_position.x - rival.global_position.x
	
	if move:
		if abs(distance) > 150 and $Salud.current > 5:
			match agresivity:
				0:
					velocity.x = speed*sign(distance)
				1:
					velocity.x = speed*-sign(distance)
		elif abs(distance) > 150 and $Salud.current <= 5:
			velocity.x = speed*sign(distance)
	

func _on_Agresividad_timeout():
	rgn.randomize()
	agresivity = rgn.randi_range(0,1)
	

func _on_Area_vision_body_entered(body):
	rgn.randomize()
	var op = rgn.randi_range(0,2)
	if op == 1:
		$AnimationPlayer.play("Punch")
		move = false

func _on_AnimationPlayer_animation_finished(anim_name):
	move = true

func _on_K_timer_timeout():
	knockback = Vector2.ZERO
