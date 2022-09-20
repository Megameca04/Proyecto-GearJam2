extends Node2D

func _ready():
	$AnimationPlayer.play("Escena 1")


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Escena 1":
			$AnimationPlayer.play("Escena 2")
		"Escena 2":
			$AnimationPlayer.play("Escena 3")
		"Escena 3":
			SceneManager.change_game()
