class_name Alchemy extends Control

signal quit
signal giveResponsability
signal giveNostalgia
signal giveReality

#func _ready():
	#await get_tree().create_timer(15).timeout
	#giveResponsability.emit()
	#await get_tree().create_timer(15).timeout
	#giveNostalgia.emit()
	#await get_tree().create_timer(15).timeout
	#giveReality.emit()
	
func spawn():
	GlobalVariables.paused = true
	show()
	update_sprites()
	self.modulate = Color.TRANSPARENT
	var tween : Tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 1)
	await tween.finished
	
func _on_quit_pressed():
	$ButtonClick.play()
	GlobalVariables.paused = false
	Engine.time_scale = 1

	var tween : Tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 1)
	await tween.finished
	hide()
	quit.emit()

func update_sprites():
	$Inventory.update_sprites()
	$Inventory.refreshSprites()

func _on_refresh_pressed():
	$Refresh.disabled = true
	$ButtonClickRefresh.play()
	update_sprites()
	for child in self.get_children(true):
		if child is AlchemySpot:
			child.occupied = false
			child.updateSprite()
	await get_tree().create_timer(2).timeout
	$Refresh.disabled = false	

func _on_inventory_check_combinatio():
	if $Future1.occupied and $Future2.occupied:
		if $Future1.itemCategory == "Future" and $Future2.itemCategory == "Future":
			giveResponsability.emit()
			$Memory.play()
			if !GlobalVariables.inventory.any(func(stri) : return stri == "ResponsabilityMemory"):
				update_sprites()
		
	if $Past1.occupied and $Past2.occupied and $Past3.occupied:
		if $Past1.itemCategory == "Past" and $Past2.itemCategory == "Past" and $Past3.itemCategory == "Past":
			giveNostalgia.emit()
			$Memory.play()
			if !GlobalVariables.inventory.any(func(stri) : return stri == "NostalgicMemory"):
				update_sprites()
			
	if $Present1.occupied and $Present2.occupied and $Present3.occupied and $Present4.occupied:
		if $Present1.itemCategory == "Present" and $Present2.itemCategory == "Present" and $Present3.itemCategory == "Present" and $Present4.itemCategory == "Present":
			giveReality.emit()
			$Memory.play()
			if !GlobalVariables.inventory.any(func(stri) : return stri == "RealityMemory"):
				update_sprites()

func _on_quit_mouse_entered():
	$ButtonHover.play()

func _on_refresh_mouse_entered():
	$ButtonHover.play()

func _on_timer_timeout():
	$Label.hide()
