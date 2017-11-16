extends Node2D

func geraMeteoro(valor):
	return get_children()[valor].duplicate()
	
func geraMeteoroRandomico():
	return get_children()[randi() % get_children().size()].duplicate()
