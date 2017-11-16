extends Node

const GRUPO_INIMIGO = "inimigos"
const GRUPO_NAVE = "nave"
const GRUPO_TIRO_INIMIGO = "tiroinimigo"

var score = 0 setget setScore #geters e seters
var vidas = 0 setget setVidas #qtd de vidas setado em welcome
var gameOver = false

signal score_changed
signal vidas_changed

func _ready():
	randomize()

func getCamera():
	return get_tree().get_root().get_node("main").get_node("camera")
	
func setScore(valor):
	if valor > 0:
		score = valor
		emit_signal("score_changed")
	
func setVidas(valor):
	vidas = valor
	emit_signal("vidas_changed")