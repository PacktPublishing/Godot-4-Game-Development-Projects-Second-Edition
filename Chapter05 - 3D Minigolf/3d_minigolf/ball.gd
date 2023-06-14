extends RigidBody3D

signal stopped

func shoot(angle, power):
	var force = Vector3.FORWARD.rotated(Vector3.UP, angle)
	apply_central_impulse(force * power)
	
func _integrate_forces(state):
	if state.linear_velocity.length() < 0.1:
		stopped.emit()
		state.linear_velocity = Vector3.ZERO
	# Ball fell off course!
	if position.y < -20:
		get_tree().reload_current_scene()
