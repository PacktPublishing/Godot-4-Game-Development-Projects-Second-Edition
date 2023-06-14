extends Node3D

func _process(delta):
	var t = $CharacterBody3d.transform.origin
	t.y = 0
	$Camera3d.look_at(t, Vector3.UP)
