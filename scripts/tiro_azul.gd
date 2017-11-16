extends "res://scripts/tiro.gd"

#tiro rapido
func _ready():
	set_process(true)
	#get_node("sample").play("tiro")
	velocidade = 900
	dano = .8