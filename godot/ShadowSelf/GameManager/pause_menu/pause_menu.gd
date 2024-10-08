extends Control

@onready var inventory = $Inventory
@onready var settings = $Settings

func _ready() -> void:
	inventory.update_sprites()
	settings.hide()
	inventory.hide()

func _process(_delta)-> void:
	if Input.is_action_just_pressed("pause"):
		if !GlobalVariables.paused:
			show()
			inventory.hide()
			Engine.time_scale = 0
			GlobalVariables.paused = true
		else:
			_on_resume_pressed()
			
func _on_resume_pressed() -> void:
	$ButtonClick.play()
	inventory.hide()
	self.hide()
	Engine.time_scale = 1
	GlobalVariables.paused = false

func _on_quit_pressed() -> void:
	$ButtonClick.play()
	get_tree().quit()

func _on_inventory_button_pressed() -> void:
	$ButtonClick.play()
	inventory.update_sprites()
	inventory.show()

func _on_settings_button_pressed():
	$ButtonClick.play()
	settings.show()


func _on_resume_mouse_entered():
	$ButtonHover.play()


func _on_quit_mouse_entered():
	$ButtonHover.play()


func _on_inventory_button_mouse_entered():
	$ButtonHover.play()


func _on_settings_button_mouse_entered():
	$ButtonHover.play()
