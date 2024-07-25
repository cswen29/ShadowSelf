extends Sprite2D

@onready var animation = $AnimatedSprite2D

func _ready():
	animation.play("blink")

func _physics_process(_delta)-> void:
	var tween = create_tween()
	tween.tween_property(self,"global_position",get_global_mouse_position(),0.17)
