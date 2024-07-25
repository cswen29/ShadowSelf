extends Control

signal yes
signal no

#no
func _on_no_pressed():
	no.emit()

#yes
func _on_yes_pressed():
	yes.emit()
