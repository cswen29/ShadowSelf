class_name RoomLevel extends Node2D

@export var minigame_scene : PackedScene
@onready var door = $Door
var minigameObj: Minigame

signal prompt 
signal spawnMinigame
signal goOutside
signal findItem

func _ready():
	var tween : Tween = create_tween()
	$".".modulate = Color.TRANSPARENT
	door.modulate = Color.TRANSPARENT
	tween.tween_property($".", "modulate", Color.WHITE, 3)
	await tween.finished

func _on_item_area_area_entered(_area):
	#spawnMinigame.emit(minigame_scene)
	findItem.emit("Gameboy")

# click on door
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if abs($Door.global_position.x - GlobalVariables.character_pos.x) < 500:
				if GlobalVariables.trees_unlocked.any(func(stri): return stri == "Future"):
					prompt.emit("Go Outside?", "outside")
				else:
					prompt.emit("I just don't feel ready to face the world...", "door")

#click on mirror
func _on_mirror_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if abs($Mirror.global_position.x - GlobalVariables.character_pos.x) < 500:
				prompt.emit("look at your self?", "mirror")

func _on_area_2d_2_area_entered(_area):
	var tween : Tween = create_tween()
	tween.tween_property(door, "modulate", Color.WHITE, 3)

func _on_middle_area_entered(_area):
	var tween : Tween = create_tween()
	tween.tween_property(door, "modulate", Color.TRANSPARENT, 3)
