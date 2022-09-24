extends Node2D

func _ready():
	$AnimationPlayer.play("Anim")

func _on_AnimationPlayer_animation_finished(anim_name):
	SceneManager.change_menu()
