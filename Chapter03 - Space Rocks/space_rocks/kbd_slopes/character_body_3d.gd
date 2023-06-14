extends CharacterBody3D

@export var gravity = -50.0
@export var speed = 5.0
@export var rot_speed = 4.0
@export var jump_speed = 15.0

var on_floor = false
var jumping = false

func _ready():
	pass
	
func get_input(delta):
	var input = Vector3.ZERO
	input += -transform.basis.z * Input.get_action_strength("forward")
	input += transform.basis.z * Input.get_action_strength("back")
	var rot = Input.get_axis("right", "left")
	rotate_y(rot * rot_speed * delta)
	velocity.x = input.x * speed
	velocity.z = input.z * speed
	
func _physics_process(delta):
	velocity.y += gravity * delta
	get_input(delta)
	
	# 1. basic movement
	move_and_slide()
	
#	floor_snap_length = 1 if not jumping else 0

	# jumping
	if jumping and is_on_floor():
		jumping = false
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if is_on_floor() and not on_floor:
		$AnimationPlayer.play("land")
		print("landed")
	on_floor = is_on_floor()

func _process(delta):
	# Animate the body's scale for squash/stretch appeal
	var sp = 20
	var sy = remap(abs(velocity.y), 0, 15, 1, 1.2)
	scale.y = lerp(scale.y, sy, sp * delta)
	var sxz = remap(abs(velocity.y), 0, 15, 1, 0.8)
	scale.x = lerp(scale.x, sxz, sp * delta)
	scale.z = lerp(scale.z, sxz, sp * delta)
