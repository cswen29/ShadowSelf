class_name RoomLevel extends Node2D

@export var minigame_scene : PackedScene
var minigameObj: Minigame

signal spawnMinigame
signal goOutside

func _ready():
	var tween : Tween = create_tween()
	$".".modulate = Color.TRANSPARENT

	tween.tween_property($".", "modulate", Color.WHITE, 3)
	await tween.finished

func _on_item_area_area_entered(_area):
	spawnMinigame.emit(minigame_scene)
	
func _on_door_area_area_entered(_area):
	var tween : Tween = create_tween()
	tween.tween_property($".", "modulate", Color.TRANSPARENT, 3)
	await tween.finished
	
	goOutside.emit()
