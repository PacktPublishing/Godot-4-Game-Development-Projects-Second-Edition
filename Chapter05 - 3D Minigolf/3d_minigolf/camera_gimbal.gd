extends Node3D

@export var cam_speed = PI / 2
@export var zoom_speed = 0.1

var zoom = 0.2

func _input(event):
	if event.is_action_pressed("cam_zoom_in"):
		zoom -= zoom_speed
	if event.is_action_pressed("cam_zoom_out"):
		zoom += zoom_speed
		
func _process(delta):
	zoom = clamp(zoom, 0.1, 2.0)
	scale = Vector3.ONE * zoom
	var y = Input.get_axis("cam_left", "cam_right")
	rotate_y(y * cam_speed * delta)
	var x = Input.get_axis("cam_up", "cam_down")
	$GimbalInner.rotate_x(x * cam_speed * delta)
	$GimbalInner.rotation.x = clamp($GimbalInner.rotation.x, -PI / 2, -0.2)
