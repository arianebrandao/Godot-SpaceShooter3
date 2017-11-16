extends Node

var pre_fabrica = preload("res://scenes/fabrica_meteoros.tscn")
var fabrica
#var intervalo = 2 - esta no timer agora

func _ready():
	fabrica = pre_fabrica.instance()

func _on_timer_intervalo_timeout():
	get_node("timer_intervalo").set_wait_time(rand_range(1.5, 2.5))
	var meteoro = fabrica.geraMeteoroRandomico()
	get_owner().add_child(meteoro)
	meteoro.set_pos(Vector2(rand_range(30, 360), -40))
	
	var timer = Timer.new()
	timer.set_wait_time(7)
	timer.connect("timeout", meteoro, "queue_free")
	timer.start()
	get_owner().add_child(timer)
	