extends Control

func _ready():
	$Label2.text = "High Score: " + str(Global.high_score)

func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
