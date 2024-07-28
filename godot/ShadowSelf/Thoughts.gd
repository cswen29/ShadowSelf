class_name Thoughts extends CharacterBody2D

signal shadowHit
signal playerHit
const SPEED = 400.0

func _physics_process(delta):
	look_at(GlobalVariables.character_pos)
	var direction = (GlobalVariables.character_pos - global_position).normalized()

	velocity = direction * SPEED

	move_and_slide()

func _on_area_2d_area_entered(area):
	if (area.name == "PlayerArea") || (area.name == "ShadowArea"):
		await get_tree().create_timer(0.1).timeout
		self.queue_free()
