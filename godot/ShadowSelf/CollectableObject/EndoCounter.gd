extends Sprite2D

@export var resource: AlchemyResource
@onready var obj_name: Label = $Label
@onready var area_2d = $Area2D
@onready var control = $"../../ResourceControl"
@onready var label: Label = $EndoCounterLabel
@onready var n = control.inventory.count("Endorphins")
var is_hidden:bool = false

func _ready():
	obj_name.text = "Endorphins"
	self.self_modulate = Color.RED
	if n == 0:
		self.hide()
	label.text = str(n)

func update_label():
	n = control.inventory.count("Endorphins")
	if n == 0:
		self.hide()
	else:
		self.show()
	label.text = str(n)
