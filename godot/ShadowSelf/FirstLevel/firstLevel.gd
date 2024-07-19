extends Node2D

@export var minigame_scene : PackedScene

func _on_area_2d_area_entered(area):
	var minigame = minigame_scene.instantiate()
	add_child(minigame)
	var mainCharacter = $MainCharacter as Player
	#mainCharacter.canMove = false
