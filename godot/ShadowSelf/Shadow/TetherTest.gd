extends Line2D

var queue:Array
@onready var constant = $".." #main_char
@onready var shadow = $Shadow ###issue


func _process(_delta):
	clear_points()
	queue.clear()
	queue.append(constant.position)
	var point1:=Vector2((constant.position.x+shadow.position.x)/2,(constant.position.y+shadow.position.y)/2)
	queue.append(Vector2((constant.position.x+point1.x)/2,(constant.position.y+point1.y)/2))
	queue.append(Vector2((constant.position.x+shadow.position.x)/2,(constant.position.y+shadow.position.y)/2))
	queue.append(Vector2((point1.x+shadow.position.x)/2,(point1.y+shadow.position.y)/2))
	queue.append(shadow.position)
	for point in queue:
		add_point(point)
