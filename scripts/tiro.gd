extends Area2D

var velocidade = 500
var dano = 1

func _ready():
	set_process(true)
	get_node("sample").play("tiro")

func _process(delta):
	set_pos(get_pos() + Vector2(0,-1) * velocidade * delta)
	
	if get_pos().y < -20:
		queue_free()

func _on_tiro_area_enter( area ):
	#print(area.get_groups())
	if area.is_in_group(game.GRUPO_INIMIGO):
		if area.has_method("aplica_dano"):
			area.aplica_dano(dano)
		else:
			area.queue_free()

		queue_free() #tiro auto se destroi
