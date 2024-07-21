extends Line2D

var queue:Array
@onready var player = $"../../PlayerBodyTest"
@onready var constant = $".."

func _process(_delta):
	clear_points()
	queue.clear()
	queue.append(constant.position)
	var point1:=Vector2((constant.position.x+player.position.x)/2,(constant.position.y+player.position.y)/2)
	queue.append(Vector2((constant.position.x+point1.x)/2,(constant.position.y+point1.y)/2))
	queue.append(Vector2((constant.position.x+player.position.x)/2,(constant.position.y+player.position.y)/2))
	queue.append(Vector2((point1.x+player.position.x)/2,(point1.y+player.position.y)/2))
	queue.append(player.position)
	for point in queue:
		add_point(point)
