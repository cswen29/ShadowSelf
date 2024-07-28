extends Node2D

var thought_scene = preload("res://thoughts.tscn")
@onready var path = $Path2D/PathFollow2D

func _process(delta):
	$Timer.paused = GlobalVariables.paused

func _on_timer_timeout():
	var thought = thought_scene.instantiate()	
	path.progress_ratio = randf()
	thought.position = path.position
	add_child(thought)
