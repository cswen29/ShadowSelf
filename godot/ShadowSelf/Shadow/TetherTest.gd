extends Line2D

var queue:Array
@onready var constant = $".."

func _process(_delta):
	clear_points()
	queue.clear()
	queue.append(constant.position)
	var point1:=Vector2((constant.position.x+constant.floaty.position.x)/2,(constant.position.y+constant.floaty.position.y)/2)
	queue.append(Vector2((constant.position.x+point1.x)/2,(constant.position.y+point1.y)/2))
	queue.append(Vector2((constant.position.x+constant.floaty.position.x)/2,(constant.position.y+constant.floaty.position.y)/2))
	queue.append(Vector2((point1.x+constant.floaty.position.x)/2,(point1.y+constant.floaty.position.y)/2))
	queue.append(constant.floaty.position)
	for point in queue:
		add_point(point)
