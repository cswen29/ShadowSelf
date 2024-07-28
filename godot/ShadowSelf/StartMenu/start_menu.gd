extends Node2D

@onready var volume: float = 0.5
var simultaneous_scene = preload("res://GameManager/game_manager.tscn")

@onready var transition = $Transition

func _ready():
	$CanvasLayer/Settings.hide()
	
func _on_start_button_pressed()-> void:
	transition.play("fade_out")
	
func _on_transition_animation_finished(anim_name):
	get_tree().change_scene_to_packed(simultaneous_scene)
	
func _on_tutorial_button_pressed()-> void:
	var tween : Tween = create_tween()
	var transparent : bool = $Tutorial.modulate == Color.TRANSPARENT
	
	if transparent:
		tween.tween_property($Tutorial, "modulate", Color.WHITE, 1)
	else:
		tween.tween_property($Tutorial, "modulate", Color.TRANSPARENT, 1)

func _on_settings_button_pressed():
	$CanvasLayer/Settings.show()
