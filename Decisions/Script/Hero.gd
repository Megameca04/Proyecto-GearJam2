extends KinematicBody2D

export (bool) var activado

var speed = 300
var jump_speed = 200
var weight = 500

var rival = null

var velocity = Vector2.ZERO

var agresivity = 0

var rgn = RandomNumberGenerator.new()

func _ready():
	$Salud.connect("depleted",self,"defeat")
	
	var rv = get_tree().get_nodes_in_group("Player")
	
	print(rv.size())
	
	var i = 0
	while i < rv.size():
		
		if rv[i] != self:
			rival = rv[i]
			
		i += 1

func _process(delta):
	animations()

func _physics_process(delta):
	velocity.x = 0
	
	velocity.y += weight * delta
	
	if activado:
		get_input()
	else:
		ia_movement()
	
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
	self.queue_free()

func _on_Area_dano_area_entered(area):
	print("a")
	$Salud.current -= 1

func ia_movement():
	var distance = self.global_position.x - rival.global_position.x
	
	if abs(distance) > 100 and $Salud.current >= 10:
		velocity.x = speed*-sign(distance)
	elif abs(distance) > 100 and 10 > $Salud.current > 5:
		match agresivity:
			0:
				velocity.x = speed*sign(distance)
			1:
				velocity.x = speed*-sign(distance)
	elif abs(distance) > 100 and $Salud.current < 5:
		velocity.x = speed*sign(distance)
	

func _on_Agresividad_timeout():
	rgn.randomize()
	agresivity = rgn.randi_range(0,1)
	
