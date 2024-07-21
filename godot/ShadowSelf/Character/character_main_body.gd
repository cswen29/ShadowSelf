extends CharacterBody2D

@onready var floaty = $"../PlayerBodyTest"
@onready var line = $Line2D
var distance

func _physics_process(_delta):
	velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down")*300
	move_and_slide()
	distance = abs(self.global_position.x - floaty.global_position.x) + abs(self.global_position.y - floaty.global_position.y)
	if distance >= 800:
		line.hide()
	else:
		line.show()
	line.width=20
	line.width=line.width+(-distance/50)

func _input(event):
	if event.is_action_pressed("leftclick"):
		print(get_global_mouse_position(),self.global_position,distance)
