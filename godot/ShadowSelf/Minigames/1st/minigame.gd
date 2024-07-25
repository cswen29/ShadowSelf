class_name Minigame extends Node2D

signal minigameIsFinished

func _ready()-> void:
	await get_tree().create_timer(5).timeout
	minigameIsFinished.emit()
	GlobalVariables.inventory.append("Key")
