class_name PickUp extends Node2D

func pickedUpItem(item: String) -> void:
	GlobalVariables.inventory.push_front(item)
	set_sprite(item)
	show()
	Engine.time_scale = 0.0
	
func set_sprite(item)-> void:
	$ItemName.text = item
	$ItemDescription.text = GlobalVariables.itemAttr[item][0]
	if $ItemName.text != "":
		$Sprite2D.texture = load(str("res://assets/inventory/" + item + ".png"))

func _on_close_pressed():
	$ButtonClick.play()
	hide()
	Engine.time_scale = 1.0

func _on_close_mouse_entered():
	$ButtonHover.play()
