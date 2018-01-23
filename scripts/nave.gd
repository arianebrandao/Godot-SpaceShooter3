extends Area2D

export var velocidade = 260
var arma #tipos de tiros
var timer_buff = Timer.new()

#classes
var tiro_simples = preload("res://scripts/classes/Tiro_simples.gd")
var tiro_duplo = preload("res://scripts/classes/Tiro_duplo.gd")
var tiro_rapido = preload("res://scripts/classes/Tiro_rapido.gd")

var armas = [
	tiro_simples.new(self),
	tiro_rapido.new(self),
	tiro_duplo.new(self)
]

func _ready():
	set_process(true)
	add_to_group(game.GRUPO_NAVE)
	arma = armas[0]
	
func _process(delta):
	var direita = 0
	var esquerda = 0
	
	if Input.is_action_pressed("direita"):
		direita = 1
	if Input.is_action_pressed("esquerda"):
		esquerda = -1
		
	if get_pos().x > 360-33:
		direita = 0
		
	if get_pos().x < 30:
		esquerda = 0
		
	set_pos(get_pos() + Vector2(1,0) * velocidade * delta * (direita + esquerda))
	
	#disparo
	if Input.is_action_pressed("tiro"):
		arma.dispara()
	
	arma.atualiza(delta)
	
func setArma(valor, segundos):
	arma = armas[valor]
	#var timer_buff = Timer.new()
	timer_buff.set_wait_time(segundos)
	timer_buff.connect("timeout", self, "_on_timer_buff")
	timer_buff.start()
	add_child(timer_buff)
	
	print(timer_buff)
	print("Segundos: " + str(timer_buff.get_wait_time()))
	
func _on_timer_buff():
	arma = armas[0]
	timer_buff.stop()

func _on_nave_area_enter( area ):
	if area.is_in_group(game.GRUPO_INIMIGO):
		if area.has_method("aplica_dano"):
			area.aplica_dano(200)
			retira_vida()
	elif area.is_in_group(game.GRUPO_TIRO_INIMIGO):
		if area.has_method("destroi"):
			area.destroi()
			retira_vida()
	
func retira_vida():
	if game.vidas >= 1:
		game.vidas -= 1
		get_node("escudo").ativa(5)
	else:
		#chama gameover em Main
		game.gameOver = true
		get_tree().get_root().get_node("main").get_node("gameover").gameOver()
