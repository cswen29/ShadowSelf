extends CharacterBody2D

func _physics_process(_delta)-> void:
	var tween = create_tween()
	tween.tween_property(self,"position",get_global_mouse_position(),0.1)
	move_and_slide()

func _input(event)-> void:
	if (event is InputEventMouseButton):
		modulate = Color.DIM_GRAY
		await get_tree().create_timer(0.2).timeout
		modulate = Color.BLACK
