extends Node2D

var thought_scene = preload("res://Enemy/thoughts.tscn")
@onready var path = $Path2D/PathFollow2D

func _process(_delta):
	position = GlobalVariables.character_pos
	$Timer.paused = GlobalVariables.paused
	if $Timer.paused:
		for idx in self.get_children():
			if idx is Thoughts:
				idx.queue_free()	

func _on_timer_timeout():
	var thought = thought_scene.instantiate()	
	path.progress_ratio = randf()
	thought.position = path.position
	get_parent().get_parent().add_child(thought)
