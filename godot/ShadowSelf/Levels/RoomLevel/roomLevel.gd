class_name RoomLevel extends Node2D

@export var minigame_scene : PackedScene
@onready var door = $Door
@onready var mirror = $"Background/-2/Mirror"
@onready var shelf = $"Background/-2/Shelf"
var minigameObj: Minigame

signal prompt 
signal spawnMinigame
signal goOutside
signal findItem

func _ready():
	door.modulate = Color("e0dfd8")
	$SFX/Ambience.play()
	
func _on_item_area_area_entered(_area):
	findItem.emit("Gameboy")

# click on door
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if door.isColliding:
				if GlobalVariables.trees_unlocked.any(func(stri): return stri == "Future"):
					prompt.emit("Go Outside?", "outside")
				else:
					prompt.emit("I just don't feel ready to face the world...", "door")

#click on mirror
func _on_mirror_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if mirror.isColliding:
				prompt.emit("look at your self?", "mirror")


func _on_shelf_input_event(viewport, event, shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if shelf.isColliding:
				prompt.emit("look at shelf?", "shelf")
