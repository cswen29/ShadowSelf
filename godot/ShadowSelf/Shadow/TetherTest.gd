extends Line2D

var queue:Array
@onready var floaty = $"../Shadow"

func _process(_delta)-> void:
	var character_position = GlobalVariables.character_pos
	clear_points()
	queue.clear()
	queue.append(character_position)
	var point1:=Vector2((character_position.x+floaty.position.x)/2,(character_position.y+floaty.position.y)/2)
	queue.append(Vector2((character_position.x+point1.x)/2,(character_position.y+point1.y)/2))
	queue.append(Vector2((character_position.x+floaty.position.x)/2,(character_position.y+floaty.position.y)/2))
	queue.append(Vector2((point1.x+floaty.position.x)/2,(point1.y+floaty.position.y)/2))
	queue.append(floaty.position)
	for point in queue:
		add_point(point)

	var tether_distance = abs(character_position.x - floaty.global_position.x) + abs(character_position.y - floaty.global_position.y)
	if tether_distance >= 2000:
		hide()
	else:
		show()
		
	width=20
	width=width+(-tether_distance/50)
