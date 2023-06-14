extends Node2D

@export var offset = Vector2(320, 0)
@export var duration = 10.0

func _ready():
	var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($TileMap, "position", offset, duration / 2.0).from_current()
	tween.tween_property($TileMap, "position", Vector2.ZERO, duration / 2.0)
