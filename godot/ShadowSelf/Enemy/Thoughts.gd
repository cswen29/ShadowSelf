class_name Thoughts extends CharacterBody2D

const SPEED = 300.0
var direction 
var sprites = [1,2,3,4,5]

func _ready():
	var rand = sprites.pick_random()
	var spritePath = str("assets/enemy/monster_", rand, ".png")
	$Sprite2D.texture = load(spritePath)
	look_at(GlobalVariables.character_pos)
	direction = (GlobalVariables.character_pos - global_position).normalized()
	
func _physics_process(_delta):
	velocity = direction * SPEED
	move_and_slide()

func _on_area_2d_area_entered(area):
	if (area.name == "PlayerArea") || (area.name == "ShadowArea"):
		await get_tree().create_timer(0.1).timeout
		self.queue_free()
		$Die.play()
