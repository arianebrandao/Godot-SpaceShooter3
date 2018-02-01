extends Area2D

export var velocidade = 260
var arma #tipos de tiros
var buff_icone
onready var timer_buff
onready var buff_stop

#classes
var tiro_simples = preload("res://scripts/classes/Tiro_simples.gd")
var tiro_duplo = preload("res://scripts/classes/Tiro_duplo.gd")
var tiro_rapido = preload("res://scripts/classes/Tiro_rapido.gd")

#Buffs icons
var buff1 = preload("res://sprites/Power-ups/powerupBlue_bolt.png")
var buff2 = preload("res://sprites/Power-ups/powerupGreen_bolt.png")

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
	
	#posiciona nave
	set_pos(get_pos() + Vector2(1,0) * velocidade * delta * (direita + esquerda))
	
	#disparo
	#if Input.is_action_pressed("tiro"):
	arma.dispara()
		
	arma.atualiza(delta)
	
func setArma(valor, segundos):
	#carrega node
	buff_icone = get_tree().get_root().get_node("main").get_node("HUD").get_node("buff_icone")
	timer_buff = buff_icone.get_node("timer_buff")
	buff_stop = buff_icone.get_node("buff_stop")
	
	#reseta buff
	timer_buff.stop()
	buff_stop.stop()
	buff_icone.get_node("anim").stop()
	
	#ativa tiro
	arma = armas[valor]
	#aparece no HUD
	var buff
	if valor == 1:
		buff = buff1
	elif valor == 2:
		buff = buff2

	buff_icone.get_node("sprite").set_texture(buff)
	buff_icone.get_node("sprite").show()
	timer_buff.start()
	
func _on_timer_buff_timeout():
	buff_icone.get_node("anim").play("flash")
	timer_buff.stop()
	buff_stop.start()

func _on_buff_stop_timeout():
	arma = armas[0]
	#esconde no HUD
	buff_icone.get_node("sprite").hide()
	buff_icone.get_node("anim").stop()
	buff_stop.stop()

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