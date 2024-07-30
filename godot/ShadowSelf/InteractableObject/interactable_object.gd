extends Sprite2D

var isColliding = false

func _ready():
	self.modulate = Color("7d7d7d")
	
func _on_area_2d_mouse_entered():
	if !GlobalVariables.paused:
		self.modulate = Color.WHITE

func _on_area_2d_mouse_exited():
	if !GlobalVariables.paused:
		self.modulate = Color("7d7d7d")

func _on_area_2d_body_entered(body):
	if body is Player:
		print(self.name)
		isColliding = true

func _on_area_2d_body_exited(body):
	if body is Player:
		isColliding = false

func _on_area_2d_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
