class_name RoomLevel extends Node2D

@onready var door = $Door
@onready var mirror = $"Mirror"
@onready var shelf = $"Shelf"
@onready var watch = $"Watch"

signal prompt

func _ready():
	$SFX/Ambience.play()
	
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

func _on_shelf_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if "PictureOfFamily" not in GlobalVariables.inventory:
				if shelf.isColliding:
					prompt.emit("look at shelf?", "shelf")
				
func _on_watch_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and watch.isColliding:
			if "Watch" not in GlobalVariables.inventory:
				prompt.emit("pickup watch?", "watch")	
				$Watch.hide()
							
func _on_right_limit_area_entered(area):
	if area.name == "PlayerArea":
		GlobalVariables.playerOffLimitsRight = true

func _on_right_limit_area_exited(area):
	if area.name == "PlayerArea":
		GlobalVariables.playerOffLimitsRight = false
		
func _on_left_limit_area_entered(area):
	if area.name == "PlayerArea":
		GlobalVariables.playerOffLimitsLeft = true

func _on_left_limit_area_exited(area):
	if area.name == "PlayerArea":
		GlobalVariables.playerOffLimitsLeft = false
