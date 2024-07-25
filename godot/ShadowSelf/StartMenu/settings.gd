extends Control

@onready var sliderMusic = $Music/SliderMusic
@onready var sliderEffects = $Effects/SliderEffects

func _ready() -> void:
	fillSliders()
	$Resume.grab_focus()
	
func _on_resume_pressed() -> void:
	self.hide()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_more_volume_music_pressed() -> void:
		if GlobalVariables.volume_music < 1.0:
			GlobalVariables.volume_music += 0.2
		fillSliders()
	
func _on_less_volume_music_pressed() -> void:
		if GlobalVariables.volume_music > 0.0:
			GlobalVariables.volume_music -= 0.2
		fillSliders()
	
func _on_more_volume_effects_pressed() -> void:
		if GlobalVariables.volume_effects < 1.0:
			GlobalVariables.volume_effects += 0.2
		fillSliders()
	
func _on_less_volume_effects_pressed() -> void:
		if GlobalVariables.volume_effects > 0.0:
			GlobalVariables.volume_effects -= 0.2
		fillSliders()
	
func fillSliders() -> void:
	sliderMusic.size.x = GlobalVariables.volume_music * 135
	sliderEffects.size.x = GlobalVariables.volume_effects * 135
