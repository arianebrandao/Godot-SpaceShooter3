extends "res://scripts/classes/Classe_inimigo.gd"

var pre_tiro = preload("res://scenes/inimigo_tiro.tscn")

signal destruiu

func _inicia():
	get_node("sprite").set_texture(recursos.randomInimigosTexturas())

func _destroi():
	_loot()
	get_node("sprite").hide()
	get_node("timer_tiro").stop()
	get_node("explosao/animacao").play("explosao")
	get_node("sample").play("explosao")
	emit_signal("destruiu")
	
func destroi():
	queue_free()

func _on_timer_tiro_timeout():
	var tiro = pre_tiro.instance()
	tiro.set_global_pos(get_node("tiro_pos").get_global_pos())
	game.getCamera().add_child(tiro)
	get_node("sample").play("tiro")
