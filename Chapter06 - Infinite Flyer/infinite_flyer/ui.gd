extends CanvasLayer

func update_fuel(value):
	$FuelBar.value = value
	
func update_score(value):
	$Score.text = str(value)
