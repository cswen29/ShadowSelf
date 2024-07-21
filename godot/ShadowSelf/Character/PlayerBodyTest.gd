extends CharacterBody2D


func _physics_process(_delta):
	var tween = create_tween()
	tween.tween_property(self,"position",get_global_mouse_position(),0.1)
	#self.position = move_toward(self.global_position,get_global_mouse_position(),0.5)
	#velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down")*500
	move_and_slide()
