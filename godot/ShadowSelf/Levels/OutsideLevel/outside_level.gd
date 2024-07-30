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

func _ready():
	$SFX/Ambience.play()
	
func _on_flower_2d_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and flower.isColliding:
			if "Flower" not in GlobalVariables.inventory:
				prompt.emit("pickup flower?", "flower")

func _on_bridge_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and bridge.isColliding:
			if "BridgePebbles" not in GlobalVariables.inventory:
				prompt.emit("look at bridge?", "bridge")

func _on_tree_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and tree.isColliding:
			if "Tree" not in GlobalVariables.inventory:
				prompt.emit("look at tree?", "tree")

func _on_watch_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and watch.isColliding:
			if "Watch" not in GlobalVariables.inventory:
				prompt.emit("pickup watch?", "watch")

func _on_gameboy_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and gameboy.isColliding:
			if "Gameboy" not in GlobalVariables.inventory:
				prompt.emit("pickup gameboy?", "gameboy")

func _on_letter_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and letter.isColliding:
			if "CollegeLetter" not in GlobalVariables.inventory:
				prompt.emit("pickup letter?", "letter")

func _on_icecream_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and icecream.isColliding:
			if "IceCream" not in GlobalVariables.inventory:
				prompt.emit("buy an incecream?", "icecream")
