extends Node

var main_menu = null

var in_anim = preload("res://Escenas/Animacion.tscn")

var game = preload("res://Escenas/Pruebas.tscn")

func change_anim():
	get_tree().change_scene_to(in_anim)

func change_game():
	get_tree().change_scene_to(game)
