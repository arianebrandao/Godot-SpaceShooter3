extends Area2D

func _ready():
	pass

func _process(delta):
	set_pos(get_global_pos() + Vector2(0, 1) * 200 * delta)
	var timer = Timer.new()
	timer.set_wait_time(6)
	timer.connect("timeout", self, "queue_free")
	timer.start()
	add_child(timer)

func _on_power_up_tiro_duplo_area_enter( nave ):
	pass
	
func _on_power_up_tiro_rapido_area_enter( nave ):
	pass