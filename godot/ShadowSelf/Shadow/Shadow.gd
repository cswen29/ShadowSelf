extends CharacterBody2D


func _physics_process(_delta):
	var tween = create_tween()
	tween.tween_property(self,"position",get_global_mouse_position(),0.1)
	move_and_slide()

func _input(event):
	if event.is_action_pressed("leftclick"):
		pass
