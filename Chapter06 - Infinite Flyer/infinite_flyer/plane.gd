extends CharacterBody3D

signal dead
signal score_changed
signal fuel_changed

# Climb/dive rate
@export var pitch_speed = 2.1
# Turn speed
@export var roll_speed = 2.5
# autolevel speed
@export var level_speed = 4.0
# forward speed
@export var forward_speed = 28
# fuel burn rate (per second)
@export var fuel_burn = 1.0

# ceiling
var max_altitude = 20

var roll_input = 0
var pitch_input = 0
var max_fuel = 10.0
var fuel = 10.0:
	set = set_fuel
var score = 0:
	set = set_score


func set_fuel(value):
	fuel = min(value, max_fuel)
	fuel_changed.emit(fuel)
	if fuel <= 0:
		die()

func set_score(value):
	score = value
	score_changed.emit(score)

func get_input(delta):
	pitch_input = Input.get_axis("pitch_down", "pitch_up")
	roll_input = Input.get_axis("roll_left", "roll_right")
	if position.y >= max_altitude and pitch_input > 0:
		position.y = max_altitude
		pitch_input = 0

func _physics_process(delta):
	# deplete fuel
	fuel -= fuel_burn * delta
	
	get_input(delta)
	
	# rotate the plane up/down
	rotation.x = lerpf(rotation.x, pitch_input, pitch_speed * delta)
	# limit the max climb angle
	rotation.x = clamp(rotation.x, deg_to_rad(-45), deg_to_rad(45))
	
	# roll the mesh left/right
	$cartoon_plane.rotation.z = lerpf($cartoon_plane.rotation.z, roll_input, roll_speed * delta)
	
	velocity = -transform.basis.z * forward_speed 
	velocity += transform.basis.x * $cartoon_plane.rotation.z / deg_to_rad(45) * forward_speed / 2.0
	
	move_and_slide()
	if get_slide_collision_count() > 0:
		die()
		
func die():
	if score > Global.high_score:
		Global.high_score = score
		Global.save_score()
	$AudioStreamPlayer.play()
	set_physics_process(false)
	$cartoon_plane.hide()
	$Explosion.show()
	$Explosion.play("default")
	await $Explosion.animation_finished
	$Explosion.hide()
	dead.emit()
	#get_tree().reload_current_scene()
