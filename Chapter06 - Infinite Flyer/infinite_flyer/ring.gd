extends Area3D

var move_x = false
var move_y = false

var move_amount = 2.5
var move_speed = 2.0

func _ready():
	$Label3D.hide()
	var tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween.stop()
	if move_y:
		tween.tween_property($CollisionShape3D, "position:y", -move_amount, move_speed)
		tween.tween_property($CollisionShape3D, "position:y", move_amount, move_speed)
		tween.play()
	if move_x:
		tween.tween_property($CollisionShape3D, "position:x", -move_amount, move_speed)
		tween.tween_property($CollisionShape3D, "position:x", move_amount, move_speed)
		tween.play()
		
func _on_body_entered(body):
	if body.name != "Plane":
		return
	$AudioStreamPlayer.play()
	$CollisionShape3D/MeshInstance3D.hide()
	var d = global_position.distance_to(body.global_position)
	if d < 2.0:
		$Label3D.text = "200"
		$Label3D.modulate = Color(1, 1, 0)
		body.fuel = 10
		body.score += 200
	elif d > 3.5:
		$Label3D.text = "50"
		body.fuel += 1
		body.score += 50
	else:
		$Label3D.text = "100"
		body.fuel += 2.5
		body.score += 100
	$Label3D.show()
	var tween = create_tween().set_parallel()
	tween.tween_property($Label3D, "position", Vector3(0, 10, 0), 1.0)
	tween.tween_property($Label3D, "modulate:a", 0.0, 0.5)


func _process(delta):
	$CollisionShape3D/MeshInstance3D.rotate_y(deg_to_rad(50) * delta)
