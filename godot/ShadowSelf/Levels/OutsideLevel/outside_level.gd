class_name OutsideLevel extends Node2D
signal goInside
signal spawnMinigame

func _on_door_area_area_entered(_area)-> void:
	var tween : Tween = create_tween()
	tween.tween_property($".", "modulate", Color.TRANSPARENT, 3)
	await tween.finished
	
	goInside.emit()
