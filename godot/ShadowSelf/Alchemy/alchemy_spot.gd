class_name AlchemySpot extends StaticBody2D

@export var occupied : bool = false
@onready var collision = $CollisionShape2D
var itemCategory
var firstModulate

func _ready():
	firstModulate = $Sprite2D.modulate 

func _process(_delta):
	if GlobalVariables.isDragging:
		modulate = Color(Color.MEDIUM_PURPLE, 0.5)
	else:
		modulate = firstModulate
	

func updateSprite():
	if occupied:
		$Sprite2D.modulate = Color(Color.AQUA, 0.1)
	else:
		$Sprite2D.modulate = modulate
