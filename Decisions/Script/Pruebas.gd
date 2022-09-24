extends Node2D

onready var salud_h1 = $Hero1/Salud
onready var salud_h2 = $Hero2/Salud

func _ready():
	var salud_h1_arra = $Control/Hero1_life

	var salud_h2_arra = $Control/Hero2_life
	
	salud_h1.connect("changed", salud_h1_arra, "set_value")
	salud_h1.connect("max_changed",salud_h1_arra, "set_max")
	
	salud_h2.connect("changed", salud_h2_arra, "set_value")
	salud_h2.connect("max_changed",salud_h2_arra, "set_max")
	
	salud_h1.initialize()
	salud_h2.initialize()
	
	$Hero1.connect("ending",self,"ending")
	$Hero2.connect("ending",self,"ending")
	
	$AnimationPlayer.play("Inicio")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Inicio":
		$Hero1.set_physics_process(true)
		$Hero1.set_process(true)
		$Hero2.set_physics_process(true)
		$Hero2.set_process(true)
	elif anim_name == "Final":
		if salud_h2.current > salud_h1.current:
			SceneManager.change_fh()
		else:
			SceneManager.change_fa()

func ending():
	$AnimationPlayer.play("Final")
