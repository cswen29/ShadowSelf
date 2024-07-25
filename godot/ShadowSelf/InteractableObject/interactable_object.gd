extends Sprite2D

func _on_area_2d_mouse_entered():
	if !GlobalVariables.paused:
		self.modulate = Color.YELLOW


func _on_area_2d_mouse_exited():
	if !GlobalVariables.paused:
		self.modulate = Color.WHITE


