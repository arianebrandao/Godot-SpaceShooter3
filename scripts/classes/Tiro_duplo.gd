#classe usada em nave.gd
var intervalo = .3
var ultimo_disparo = 0
var nave
var pre_tiro = preload("res://scenes/tiro_verde.tscn")

func _init(nave):
	self.nave = nave
	pass

func dispara():
	if ultimo_disparo <= 0:
		cria_tiro(nave.get_node("posCanhaoE"))
		cria_tiro(nave.get_node("posCanhaoD"))
		ultimo_disparo = intervalo
		pass
	pass
	
func atualiza(delta):
	if ultimo_disparo > 0:
		ultimo_disparo -= delta
	pass
	
func cria_tiro(node):
	var tiro = pre_tiro.instance()
	# tiro.set_global_pos(get_global_pos()) - pegando pos da nave
	tiro.set_global_pos(node.get_global_pos())
	nave.get_owner().add_child(tiro)
	pass