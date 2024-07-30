extends Control

func _ready() -> void:
	$Resume.grab_focus()
	
func _on_resume_pressed() -> void:
	$ButtonClick.play()
	self.hide()

func _on_resume_mouse_entered():
	$ButtonHover.play()
