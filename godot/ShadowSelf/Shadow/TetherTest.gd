extends Line2D

var queue:Array
@onready var player = $"../Shadow"

func _process(_delta)-> void:
	var character_position = GlobalVariables.player_pos
	clear_points()
	queue.clear()
	queue.append(character_position)
	var point1:=Vector2((character_position.x+player.position.x)/2,(character_position.y+player.position.y)/2)
	queue.append(Vector2((character_position.x+point1.x)/2,(character_position.y+point1.y)/2))
	queue.append(Vector2((character_position.x+player.position.x)/2,(character_position.y+player.position.y)/2))
	queue.append(Vector2((point1.x+player.position.x)/2,(point1.y+player.position.y)/2))
	queue.append(player.position)
	for point in queue:
		add_point(point)
