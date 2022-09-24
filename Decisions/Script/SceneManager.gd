extends Node

var main_menu = preload("res://Inicio.tscn")

var in_anim = preload("res://Escenas/Animacion.tscn")

var game = preload("res://Escenas/Pruebas.tscn")

var final_h = preload("res://Escenas/Fhumano.tscn")

var final_a = preload("res://Escenas/FAlien.tscn")

func change_menu():
	get_tree().change_scene_to(main_menu)
	
func change_anim():
	get_tree().change_scene_to(in_anim)

func change_game():
	get_tree().change_scene_to(game)

func change_fh():
	get_tree().change_scene_to(final_h)

func change_fa():
	get_tree().change_scene_to(final_a)
