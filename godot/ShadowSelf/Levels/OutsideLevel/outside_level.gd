class_name OutsideLevel extends Node2D
@export var room_level_scene : PackedScene
signal goInside
signal spawnMinigame

func _on_door_area_area_entered(area):
	var tween : Tween = create_tween()
	tween.tween_property($".", "modulate", Color.TRANSPARENT, 3)
	await tween.finished
	
	goInside.emit()
