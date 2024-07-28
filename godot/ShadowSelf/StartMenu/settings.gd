extends Control

func _ready() -> void:
	$Resume.grab_focus()
	
func _on_resume_pressed() -> void:
	self.hide()
