extends Control

signal yes

func spawn(stri, object):
	GlobalVariables.paused = true
	self.name = object
	if name  == "door":
		$No.hide()
		$Yes.text = "Ok"
	else:
		$No.show()
		$Yes.text = "Yes"
	
	$Background/Label.text = stri 
	show()
	Engine.time_scale = 0.0

#no
func _on_no_pressed():
	hide()
	GlobalVariables.paused = false
	Engine.time_scale = 1

#yes
func _on_yes_pressed():
	hide()
	GlobalVariables.paused = false
	Engine.time_scale = 1.0
	yes.emit()

