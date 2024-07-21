extends Control

@onready var names:Array = ["Dopamine","Serotonin","Endorphins"]
@onready var inventory:Array = []
@onready var sero_counter = $"../CanvasLayer/SeroCounter"
@onready var dopa_counter = $"../CanvasLayer/DopaCounter"
@onready var endo_counter = $"../CanvasLayer/EndoCounter"

func _ready():
	for child in get_children():
		child.obj_name.text = names.pick_random()

func pick_new_names():
	for child in get_children():
		if child.is_hidden:
			child.obj_name.text = names.pick_random()

func update_counter():
	sero_counter.update_label()
	dopa_counter.update_label()
	endo_counter.update_label()
