extends Node2D

var pre_inimigo = preload("res://scenes/inimigos/path_inimigo.tscn")

func _ready():
	randomize_timer()

func randomize_timer():
	get_node("timer_spawn").set_wait_time(rand_range(5, 15))

func _on_timer_spawn_timeout():
	var inimigo = pre_inimigo.instance()
	get_parent().add_child(inimigo)
	randomize_timer()