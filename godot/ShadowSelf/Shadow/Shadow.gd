class_name Shadow extends CharacterBody2D

signal shadowEat
func _physics_process(_delta)-> void:
	var tween = create_tween()
	tween.tween_property(self,"position",get_global_mouse_position(),0.2)
	move_and_slide()
	
func _input(event)-> void:
	if (event is InputEventMouseButton):
		var tween = create_tween()
		
		tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.2)
		tween.tween_property(self, "modulate", Color.WHITE, 0.2)
		tween.tween_property($Sprite2D2, "modulate", Color.TRANSPARENT, 0.2)
		tween.tween_property($Sprite2D2, "modulate", Color.WHITE, 0.2)
		
func _on_area_2d_body_entered(body):	
	if body is Thoughts:
		shadowEat.emit()
