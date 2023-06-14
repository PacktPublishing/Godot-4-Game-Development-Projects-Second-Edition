extends Camera3D

@export var target_path : NodePath
@export var offset = Vector3.ZERO

var target = null

func _ready():
	if target_path:
		target = get_node(target_path)
		position = target.position + offset
		look_at(target.position)

func _physics_process(_delta):
	if !target:
		return
	position = target.position + offset
