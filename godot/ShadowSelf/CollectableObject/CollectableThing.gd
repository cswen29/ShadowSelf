extends Sprite2D

@export var resource: AlchemyResource
@onready var obj_name: Label = $Label
@onready var area_2d = $Area2D


func _ready():
	obj_name.text = "Dopamine"

func _on_area_2d_mouse_entered():
	self.hide()
	area_2d.monitoring = false
	await get_tree().create_timer(5.0).timeout
	self.show()
	area_2d.monitoring = true
