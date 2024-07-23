extends Control

signal resume 
signal quit
@onready var sliderMusic = $SliderMusic
@onready var sliderEffects = $SliderEffects

func _ready():
	fillSliders()
	
func _on_resume_pressed():
	resume.emit()

func _on_quit_pressed():
	quit.emit()

func _on_more_volume_music_pressed():
	if GlobalVariables.volume_music < 1.0:
		GlobalVariables.volume_music += 0.2
	fillSliders()
	
func _on_less_volume_music_pressed():
	if GlobalVariables.volume_music > 0.0:
		GlobalVariables.volume_music -= 0.2
	fillSliders()
	
func _on_more_volume_effects_pressed():
	if GlobalVariables.volume_effects < 1.0:
		GlobalVariables.volume_effects += 0.2
	fillSliders()
	
func _on_less_volume_effects_pressed():
	if GlobalVariables.volume_effects > 0.0:
		GlobalVariables.volume_effects -= 0.2
	fillSliders()
	
func fillSliders():
	sliderMusic.size.x = GlobalVariables.volume_music * 135
	sliderEffects.size.x = GlobalVariables.volume_effects * 135
