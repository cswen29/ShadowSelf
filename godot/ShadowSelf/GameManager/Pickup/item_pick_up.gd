class_name PickUp extends Control

signal closePickUp
var itemName : String = ""

func set_sprite():
	$ItemName.text = itemName
	if $ItemName.text != "":
		$Sprite2D.texture = load(str("res://assets/inventory/" + $ItemName.text + ".png"))
		$Sprite2D.scale = Vector2(0.05,0.05)
		
func _on_ok_pressed(): 
	closePickUp.emit()
