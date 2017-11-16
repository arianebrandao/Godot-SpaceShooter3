extends Area2D

const giro = 720
const vel = 200
const direcao = Vector2(0, 1)

func _ready():
	add_to_group(game.GRUPO_TIRO_INIMIGO)
	set_process(true)
	pass

func _process(delta):
	rotate(deg2rad(giro) * delta) #graus
	translate(direcao * vel * delta)
	
func destroi():
	queue_free()