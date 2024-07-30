extends Control

var list = []
signal checkCombinatio

func _ready() -> void:
	if get_parent().name == "Alchemy":
		$Close.hide()
	update_sprites()
	
func update_sprites():
	list = GlobalVariables.inventory
	for node_name in list:
		var node_parent = GlobalVariables.itemAttr[node_name][2]
		var path = str(node_parent + "/" + node_name)
		var sprite = get_node(path) as Item
		if sprite != null:
			sprite.update()
			sprite.show()
	#	
func refreshSprites():
	var tween = create_tween().set_parallel(true)
	for child in self.get_children():
		for grandChild in child.get_children():
			if grandChild is Item:
				grandChild.skip = false
				grandChild.hideName()
				tween.tween_property(grandChild, "global_position", grandChild.actual_initialPos, 1 )
				tween.tween_property(grandChild, "rotation", grandChild.rotation + deg_to_rad(360.0), 1 )
	
	await tween.finished
	
	for child in self.get_children():
		for grandChild in child.get_children():
			if grandChild is Item:
				grandChild.showName()

func check_combinations():
	checkCombinatio.emit()

func _on_close_pressed():
	$ButtonClick.play()
	self.hide()

func _on_close_mouse_entered():
	$ButtonHover.play()
