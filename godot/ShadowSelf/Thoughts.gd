class_name Thoughts extends CharacterBody2D

signal shadowHit
signal playerHit
const SPEED = 300.0
var direction 

func _ready():
	look_at(GlobalVariables.character_pos)
	direction = (GlobalVariables.character_pos - global_position).normalized()
	
func _physics_process(_delta):
	velocity = direction * SPEED
	move_and_slide()

func _on_area_2d_area_entered(area):
	if (area.name == "PlayerArea") || (area.name == "ShadowArea"):
		await get_tree().create_timer(0.01).timeout
		self.queue_free()
		$Die.play()
