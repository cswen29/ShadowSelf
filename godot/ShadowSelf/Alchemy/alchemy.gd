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
	update_sprites()
	for child in self.get_children(true):
		if child is AlchemySpot:
			child.occupied = false
			child.updateSprite()

func _on_inventory_check_combinatio():
	if $Future1.occupied and $Future2.occupied:
		if $Future1.itemCategory == "Future" and $Future2.itemCategory == "Future":
			giveResponsability.emit()
			
	if $Past1.occupied and $Past2.occupied and $Past3.occupied:
		if $Past1.itemCategory == "Past" and $Past2.itemCategory == "Past" and $Past3.itemCategory == "Past":
			giveNostalgia.emit()
			
	if $Present1.occupied and $Present2.occupied and $Present3.occupied and $Present4.occupied:
		if $Present1.itemCategory == "Present" and $Present2.itemCategory == "Present" and $Present3.itemCategory == "Present" and $Present4.itemCategory == "Present":
			giveReality.emit()
