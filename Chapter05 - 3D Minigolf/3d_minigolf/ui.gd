extends CanvasLayer

@onready var power_bar = $MarginContainer/VBoxContainer/PowerBar
@onready var shots = $MarginContainer/VBoxContainer/Shots

var bar_textures = {
	"green": preload("res://assets/bar_green.png"),
	"yellow": preload("res://assets/bar_yellow.png"),
	"red": preload("res://assets/bar_red.png")
}

# Alternative color changing procedure - use the white bar texture.
#var grad = preload("res://gyr_gradient.tres")

func update_shots(value):
	shots.text = "Shots: %s" % value

func update_power_bar(value):
	power_bar.texture_progress = bar_textures["green"]
	if value > 70:
		power_bar.texture_progress = bar_textures["red"]
	elif value > 40:
		power_bar.texture_progress = bar_textures["yellow"]
	# Uncomment this line to set the color based on the gradient.
	# And remove the lines above
#	power_bar.modulate = grad.sample(value / 100.0)
	power_bar.value = value

func show_message(text):
	$Message.text = text
	$Message.show()
	await get_tree().create_timer(2).timeout
	$Message.hide()
