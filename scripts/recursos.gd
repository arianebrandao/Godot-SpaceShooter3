extends Node

const path_dir = "res://paths/"
const inimigos_tex_dir = "res://sprites/Enemies/"

var paths = []
var inimigos_tex = []

func _ready():
	carregaPaths()
	carregaTexturaInimigos()
	pass
	
func randomPaths():
	return paths[randi() % paths.size()]
	pass
	
func randomInimigosTexturas():
	return inimigos_tex[randi() % inimigos_tex.size()]
	pass

func carregaPaths():
	var dir = Directory.new()
	dir.change_dir(path_dir)
	dir.list_dir_begin()
	
	var path_file = dir.get_next()
	
	while path_file != "":
		var path = load(path_dir + path_file)
		if path && path extends Curve2D:
			paths.append(path)
			
		path_file = dir.get_next()
		
	#print("Caminhos carregados " + str(paths.size()))
	
func carregaTexturaInimigos():
	var dir = Directory.new()
	dir.change_dir(inimigos_tex_dir)
	dir.list_dir_begin()
	
	var textura_file = dir.get_next()
	
	while textura_file != "":
		var file = load(inimigos_tex_dir + textura_file)
		if file && file extends Texture:
			inimigos_tex.append(file)
			
		textura_file = dir.get_next()