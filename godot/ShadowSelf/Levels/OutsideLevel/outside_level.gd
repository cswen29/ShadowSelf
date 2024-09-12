class_name OutsideLevel extends Node2D

signal prompt

@onready var flower = $Flower
@onready var tree =  $NostalgicTree
@onready var bridge = $NostalgicBridge
@onready var gameboy = $Gameboy
@onready var letter =  $CollegeLetter
@onready var icecream = $IceCream
@onready var playersHouse = $playersHouse

func _ready():
	$SFX/Ambience.play()
	
func _on_flower_2d_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and flower.isColliding:
			if "Flower" not in GlobalVariables.inventory:
				prompt.emit("pickup flower?", "flower")
				$Flower.hide()
func _on_bridge_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and bridge.isColliding:
			if "BridgePebbles" not in GlobalVariables.inventory:
				prompt.emit("look at lake?", "bridge")
				$NostalgicBridge.self_modulate = Color(Color.WHITE, 0.9)

func _on_tree_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and tree.isColliding:
			if "Tree" not in GlobalVariables.inventory:
				prompt.emit("look at tree?", "tree")
				$NostalgicTree.self_modulate = Color(Color.WHITE, 0.5)

func _on_gameboy_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and gameboy.isColliding:
			if "Gameboy" not in GlobalVariables.inventory:
				prompt.emit("pickup gameboy?", "gameboy")
				$Gameboy.hide()
				
func _on_letter_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and letter.isColliding:
			if "CollegeLetter" not in GlobalVariables.inventory:
				prompt.emit("pickup letter?", "letter")
				$CollegeLetter.self_modulate = Color(Color.WHITE, 0.5)

func _on_icecream_input_event(_viewport, event, _shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and icecream.isColliding:
			if "IceCream" not in GlobalVariables.inventory:
				prompt.emit("buy an incecream?", "icecream")
				$IceCream.self_modulate = Color(Color.WHITE, 0.5)

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

func _on_area_2d_input_event(viewport, event, shape_idx):
	if !GlobalVariables.paused:
		if event is InputEventMouseButton and playersHouse.isColliding:
			prompt.emit("Go Inside?", "inside")
