extends Control

signal gameOver

func _on_retry_pressed():
	$ButtonClick.play()
	gameOver.emit()

func _on_retry_mouse_entered():
	$ButtonHover.play()
