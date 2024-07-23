extends Sprite2D

@onready var animation_player = $AnimationPlayer

func _ready():
	var playspeed = randf_range(2.0,5.0)
	animation_player.play("blink_anim",-1,playspeed)
	await get_tree().create_timer(randf_range(1.0,3.0)).timeout
	animation_player.play("blink_anim",-1,playspeed)
