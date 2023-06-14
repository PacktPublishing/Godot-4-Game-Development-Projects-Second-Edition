extends Area2D

signal picked_up

var textures = {
	"cherry": "res://assets/sprites/cherry.png",
	"gem": "res://assets/sprites/gem.png"
}

func init(type, _position):
	$Sprite2d.texture = load(textures[type])
	position = _position


func _on_item_body_entered(body):
	picked_up.emit()
	queue_free()
