class_name Alchemy extends Control

signal quit
signal giveResponsability
signal giveNostalgia
signal giveReality

func _on_quit_pressed():
	quit.emit()

func update_sprites():
	$Inventory.update_sprites()
	$Inventory.refreshSprites()

func _on_refresh_pressed():
	update_sprites()
	for child in self.get_children(true):
		if child is AlchemySpot:
			child.occupied = false
			child.updateSprite()

func _on_inventory_check_combinatio():
	if $Future1.occupied and $Future2.occupied:
		if $Future1.itemCategory == "Future" and $Future2.itemCategory == "Future":
			giveResponsability.emit()
			print("giveResponsability")
			
	if $Past1.occupied and $Past2.occupied and $Past3.occupied:
		if $Past1.itemCategory == "Past" and $Past2.itemCategory == "Past" and $Past3.itemCategory == "Past":
			giveNostalgia.emit()
			print("giveNostalgia")
			
	if $Present1.occupied and $Present2.occupied and $Present3.occupied and $Present4.occupied:
		if $Present1.itemCategory == "Present" and $Present2.itemCategory == "Present" and $Present3.itemCategory == "Present" and $Present4.itemCategory == "Present":
			giveReality.emit()
			print("giveReality")
