extends CharacterBody2D

signal life_changed
signal died

@export var gravity = 750
@export var run_speed = 150
@export var jump_speed = -300
@export var climb_speed = 50
@export var max_jumps = 2
@export var double_jump_factor = 1.5

enum {IDLE, RUN, JUMP, HURT, DEAD, CLIMB}
var state = IDLE
var jump_count = 0
var last_floor = false
var is_on_ladder = false
var life = 3: 
	set = set_life

func _ready():
	change_state(IDLE)

func reset(_position):
	position = _position
	show()
	change_state(IDLE)
	life = 3
	
func hurt():
	if state != HURT:
		$HurtSound.play()
		change_state(HURT)
	
func get_input():
	if state == HURT:
		return  # don't allow movement during hurt state
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	
	# climbing ladder
	if up and state != CLIMB and is_on_ladder:
		change_state(CLIMB)
	if state == CLIMB:
		if up:
			velocity.y = -climb_speed
			$AnimationPlayer.play("climb")
		elif down:
			velocity.y = climb_speed
			$AnimationPlayer.play("climb")
		else:
			velocity.y = 0
			$AnimationPlayer.stop()
	if state == CLIMB and not is_on_ladder:
		change_state(IDLE)
	# movement occurs in all states
	velocity.x = 0
	if right:
		velocity.x += run_speed if state != CLIMB else run_speed / 3
		$Sprite2d.flip_h = false
	if left:
		velocity.x -= run_speed if state != CLIMB else run_speed / 3
		$Sprite2d.flip_h = true
	# double jumping
	if jump and state == JUMP and jump_count < max_jumps and jump_count > 0:
		$JumpSound.play()
		$AnimationPlayer.play("jump_up")
		velocity.y = jump_speed / double_jump_factor
		jump_count += 1
	# only allow jumping when on the ground
	if jump and is_on_floor():
		$JumpSound.play()
		change_state(JUMP)
		velocity.y = jump_speed
	# IDLE transitions to RUN when moving
	if state == IDLE and velocity.x != 0:
		change_state(RUN)
	# RUN transitions to IDLE when standing still
	if state == RUN and velocity.x == 0:
		change_state(IDLE)
	# transition to JUMP when in the air
	if state in [IDLE, RUN] and !is_on_floor():
		change_state(JUMP)
	
	
func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			$AnimationPlayer.play("idle")
		RUN:
			$AnimationPlayer.play("run")
		HURT:
			$AnimationPlayer.play("hurt")
			velocity.y = -200
			velocity.x = -100 * sign(velocity.x)
			life -= 1
			await get_tree().create_timer(0.5).timeout
			change_state(IDLE)
			if life <= 0:
				change_state(DEAD)
		JUMP:
			$AnimationPlayer.play("jump_up")
			jump_count = 1
		DEAD:
			died.emit()
			hide()
		CLIMB:
			$AnimationPlayer.play("climb")
			
func _physics_process(delta):	
	if state != CLIMB:
		velocity.y += gravity * delta
	get_input()
	
	move_and_slide()
	if state == HURT:
		return
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("danger"):
			hurt()
		if collision.get_collider().is_in_group("enemies"):
			if position.y < collision.get_collider().position.y:
				collision.get_collider().take_damage()
				velocity.y = -200
			else:
				hurt()
	
	if state == JUMP and is_on_floor():
		change_state(IDLE)
		jump_count = 0
		$Dust.emitting = true
	if state == JUMP and velocity.y > 0:
		$AnimationPlayer.play("jump_down")
	last_floor = is_on_floor()

func set_life(value):
	life = value
	life_changed.emit(life)

