extends Control

@onready var transition = $Transition
signal gameOver

func _on_retry_pressed():
	gameOver.emit()
