extends Area2D

export var vida = 2
export var pontos = 10
export var chanceLoot = 20

var powerup_tiro_duplo = preload("res://scenes/power_up_tiro_duplo.tscn")
var powerup_tiro_rapido = preload("res://scenes/power_up_tiro_rapido.tscn")

var loots = [
	powerup_tiro_duplo.instance(),
	powerup_tiro_rapido.instance()
]

func _ready():
	add_to_group(game.GRUPO_INIMIGO)
	_inicia()

func aplica_dano(valor):
	vida -= valor
	if vida <= 0:
		_destroi()
		game.score += pontos
		set_process(false)
		set_z(10)
		remove_from_group(game.GRUPO_INIMIGO)
		game.getCamera().shake()
	else:
		_hit()
	
func _inicia():
	pass

func _hit():
	pass

func _loot():
	var loot = randi() % 100
	if loot < chanceLoot:
		var powerup = loots[randi() % loots.size()]
		powerup.set_global_pos(get_node("sprite").get_global_pos())
		game.getCamera().add_child(powerup)
		powerup.set_process(true)
	
func _destroi():
	pass