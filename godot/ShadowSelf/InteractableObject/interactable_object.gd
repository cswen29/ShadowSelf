extends Sprite2D

var isColliding = false

func _on_area_2d_mouse_entered():
	if !GlobalVariables.paused:
		self.modulate = Color.WHITE

func _on_area_2d_mouse_exited():
	if !GlobalVariables.paused:
		self.modulate = Color("e0dfd8")

func _on_area_2d_body_entered(body):
	if body is Player:
		print(self.name)
		isColliding = true

func _on_area_2d_body_exited(body):
	if body is Player:
		isColliding = false
