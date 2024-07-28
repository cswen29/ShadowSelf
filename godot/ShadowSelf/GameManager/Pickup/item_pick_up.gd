class_name PickUp extends Control

signal closePickUp

func pickedUpItem(item: String) -> void:
	GlobalVariables.inventory.push_front(item)
	set_sprite(item)
	show()
	Engine.time_scale = 0.0
	
func set_sprite(item)-> void:
	$ItemName.text = item
	if $ItemName.text != "":
		$Sprite2D.texture = load(str("res://assets/inventory/" + item + ".png"))

func _on_ok_pressed()-> void:
	hide()
	Engine.time_scale = 1.0
