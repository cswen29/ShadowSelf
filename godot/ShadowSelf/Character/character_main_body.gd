extends CharacterBody2D

@onready var floaty = $"../PlayerBodyTest"
@onready var line = $Line2D

func _physics_process(_delta):
	velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down")*300
	move_and_slide()
	var distance = abs((self.global_position.x - floaty.global_position.x + self.global_position.y - floaty.global_position.y))
	if distance >= 800:
		line.hide()
	else:
		line.show()
	print(line.width)
	line.width=20
	line.width=line.width+(-distance/50)
