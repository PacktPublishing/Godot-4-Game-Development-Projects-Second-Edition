extends Control

func _input(event):
	if event.is_action_pressed("ui_select"):
		GameState.next_level()
