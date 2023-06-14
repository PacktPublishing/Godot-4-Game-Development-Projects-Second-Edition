extends Node

@export var rock_scene : PackedScene
@export var enemy_scene: PackedScene

var screensize = Vector2.ZERO
var level = 0
var score = 0
var playing = false

func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	for i in 3:
		spawn_rock(3)

func _input(event):
	if event.is_action_pressed("pause"):
		if not playing:
			return
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			$HUD/Message.text = "Paused"
			$HUD/Message.show()
		else:
			$HUD/Message.text = ""
			$HUD/Message.hide()
	
	
func spawn_rock(size, pos=null, vel=null):
	if pos == null:
		$RockPath/RockSpawn.progress = randi()
		pos = $RockPath/RockSpawn.position
	if vel == null:
		vel = Vector2.RIGHT.rotated(randf_range(0, TAU)) * randf_range(50, 125)
	var r = rock_scene.instantiate()
	r.screensize = screensize
	r.start(pos, vel, size)
	call_deferred("add_child", r)
	r.exploded.connect(self._on_rock_exploded)
	
func _on_rock_exploded(size, radius, pos, vel):
	$ExplosionSound.play()
	score += 10 * size
	$HUD.update_score(score)
	if size <= 1:
		return
	for offset in [-1, 1]:
		var dir = $Player.position.direction_to(pos).orthogonal() * offset
		var newpos = pos + dir * radius
		var newvel = dir * vel.length() * 1.1
		spawn_rock(size - 1, newpos, newvel)

func new_game():
	get_tree().call_group("rocks", "queue_free")
	level = 0
	score = 0
	$HUD.update_score(score)
	$Player.reset()
	$HUD.show_message("Get Ready!")
	await $HUD/Timer.timeout
	playing = true
	$Music.play()
	
func new_level():
	$LevelupSound.play()
	$EnemyTimer.start(randf_range(5, 10))
	level += 1
	$HUD.show_message("Wave %s" % level)
	for i in level:
		spawn_rock(3)

func _process(delta):
	if !playing:
		return
	if get_tree().get_nodes_in_group("rocks").size() == 0:
		new_level()

func game_over():
	playing = false
	$HUD.game_over()
	$Music.stop()


func _on_enemy_timer_timeout():
	var e = enemy_scene.instantiate()
	add_child(e)
	e.target = $Player
	$EnemyTimer.start(randf_range(20, 40))
	
	
