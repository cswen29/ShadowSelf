extends Control

@onready var names:Array = ["Dopamine","Serotonin","Endorphins"]
@onready var inventory:Array = []

func _ready():
	for child in get_children():
		child.obj_name.text = names.pick_random()

func pick_new_names():
	for child in get_children():
		if child.is_hidden:
			child.obj_name.text = names.pick_random()
