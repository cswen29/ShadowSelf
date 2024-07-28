class_name OutsideLevel extends Node2D

signal goInside
signal prompt

@onready var flower = $Flower
@onready var tree =  $NostalgicTree
@onready var bridge = $NostalgicBridge
@onready var watch =  $Watch
@onready var gameboy = $Gameboy
@onready var letter =  $CollegeLetter
@onready var icecream = $IceCream

func _on_door_area_area_entered(_area)-> void:
	var tween : Tween = create_tween()
	tween.tween_property($".", "modulate", Color.TRANSPARENT, 3)
	await tween.finished
	
	goInside.emit(false)

func _on_flower_2d_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if "Flower" not in GlobalVariables.inventory:
				prompt.emit("pickup flower?", "flower")

func _on_bridge_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if "BridgePebbles" not in GlobalVariables.inventory:
				prompt.emit("look at bridge?", "bridge")

func _on_tree_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if "Tree" not in GlobalVariables.inventory:
				prompt.emit("look at tree?", "tree")

func _on_watch_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if "Watch" not in GlobalVariables.inventory:
				prompt.emit("pickup watch?", "watch")

func _on_gameboy_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if "Gameboy" not in GlobalVariables.inventory:
				prompt.emit("pickup gameboy?", "gameboy")

func _on_letter_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if "CollegeLetter" not in GlobalVariables.inventory:
				prompt.emit("pickup letter?", "letter")

func _on_icecream_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton:
			if "IceCream" not in GlobalVariables.inventory:
				prompt.emit("buy an incecream?", "icecream")
