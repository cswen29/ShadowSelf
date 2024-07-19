extends Sprite2D

@export var resource: AlchemyResource
@onready var obj_name: Label = $Label
@onready var area_2d = $Area2D
@onready var control = $".."
var is_hidden:bool = false


func _ready():
	hide_me()
	if obj_name.text == "Serotonin":
		self.self_modulate = Color.ALICE_BLUE
	elif obj_name.text == "Endorphins":
		self.self_modulate = Color.RED
	elif obj_name.text == "Dopamine":
		self.self_modulate = Color.GREEN

func _on_area_2d_mouse_entered():
	control.inventory.append(obj_name.text)
	print(control.inventory)
	hide_me()

func hide_me():
	self.hide()
	is_hidden = true
	area_2d.monitoring = false
	await get_tree().create_timer(5.0).timeout
	show_me()

func show_me():
	control.pick_new_names()
	if obj_name.text == "Serotonin":
		self.self_modulate = Color.ALICE_BLUE
	elif obj_name.text == "Endorphins":
		self.self_modulate = Color.RED
	elif obj_name.text == "Dopamine":
		self.self_modulate = Color.GREEN
	is_hidden = false
	self.show()
	area_2d.monitoring = true
