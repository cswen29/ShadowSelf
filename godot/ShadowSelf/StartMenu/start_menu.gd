extends Node2D

@export var game_scene : PackedScene
@onready var volume: float = 0.5

func _ready():
	$CanvasLayer/Settings.hide()
	$Layer1.volume_db += GlobalVariables.volume_music * 10
	
func _on_start_button_pressed()-> void:
	var tween : Tween = create_tween().set_parallel(true)
	tween.tween_property(self, "transform", transform.rotated(deg_to_rad(-4)).scaled(Vector2(2,2)), 1.5)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 2)
	await tween.finished
	get_tree().change_scene_to_packed(game_scene)

func _on_tutorial_button_pressed()-> void:
	var tween : Tween = create_tween()
	var transparent : bool = $Tutorial.modulate == Color.TRANSPARENT
	
	if transparent:
		tween.tween_property($Tutorial, "modulate", Color.WHITE, 1)
	else:
		tween.tween_property($Tutorial, "modulate", Color.TRANSPARENT, 1)

func _on_settings_button_pressed():
	$CanvasLayer/Settings.show()
	pass # Replace with function body.
