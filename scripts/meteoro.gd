extends "res://scripts/classes/Classe_inimigo.gd"

var vel = 200 #velocidade
var rot = 0 #rotação
	
func _process(delta):
	set_pos(get_pos() + Vector2(0, 1) * vel * delta)
	rotate(deg2rad(rot * delta))
	
func _inicia():
	set_process(true)
	rot = rand_range(-160, 160)
	
func _hit():
	get_node("animacao").play("hit")

func _destroi():
	_loot()
	get_node("sample").play("explosao")
	get_node("animacao").play("destroy")