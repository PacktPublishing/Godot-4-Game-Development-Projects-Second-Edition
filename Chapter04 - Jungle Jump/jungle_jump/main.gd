extends Node

func _ready():
	var level_num = str(GameState.current_level).pad_zeros(2)
	var path = "res://levels/level_%s.tscn" % level_num
	var level = load(path).instantiate()
	add_child(level)
	
	
