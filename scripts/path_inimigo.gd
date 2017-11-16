extends Path2D

onready var follow = get_node("follow")
var vel = rand_range(140, 260)

func _ready():
	set_curve(recursos.randomPaths())
	set_process(true)
	get_node("follow/inimigo_01").connect("destruiu", self, "_on_destruiu")
	
func _process(delta):
	follow.set_offset(follow.get_offset() + vel * delta)
	if follow.get_unit_offset() >= 1:
		queue_free()
	pass

func _on_destruiu():
	set_process(false)
	var timer = Timer.new()
	timer.set_wait_time(2)
	timer.connect("timeout", self, "queue_free")
	timer.start()
	add_child(timer)