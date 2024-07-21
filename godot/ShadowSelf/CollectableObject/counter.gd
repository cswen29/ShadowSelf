extends Sprite2D

@export var resource: AlchemyResource
@onready var obj_name: Label = $Label
@onready var area_2d = $Area2D
@onready var control = $"../../ResourceControl"
@onready var label: Label = $LabelCounter
@onready var n = control.inventory.count("Serotonin")
var is_hidden:bool = false
var hover_me:bool = false

func _ready():
	if resource.type == 0:
		obj_name.text = "Dopamine"
	elif resource.type == 1:
		obj_name.text = "Serotonin"
	elif resource.type == 2:
		obj_name.text = "Endorphins"
	if obj_name.text == "Serotonin":
		self.self_modulate = Color.ALICE_BLUE
	elif obj_name.text == "Endorphins":
		self.self_modulate = Color.RED
	elif obj_name.text == "Dopamine":
		self.self_modulate = Color.GREEN
	if n == 0:
		self.hide()
	label.text = str(n)

func update_label():
	n = control.inventory.count(obj_name.text)
	if n == 0:
		self.hide()
	else:
		self.show()
	label.text = str(n)

func _on_area_2d_mouse_entered():
	hover_me = true
