extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	$ColorRect.visible = false
	
	$Label.text = ""  
	$Label2.text =  ""  
	$Label3.text =  ""  
	$Label4.text =  ""  
	$TextureRect/Label.text = ""  
	$TextureRect/Label2.text =  ""  
	$TextureRect/Label3.text =  ""  
	$TextureRect/Label4.text =  ""  
	$TextureRect2/Label.text = ""  
	$TextureRect2/Label2.text =  ""  
	$TextureRect2/Label3.text =  ""  
	$TextureRect2/Label4.text =  ""  
	
	var tween = create_tween()
	tween.tween_property($Label, "text", "You've conquered your shadow.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($Label2, "text", "You walk slowly pass the tree you used to play with your dad.", 2.5)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($Label3, "text", "You keep walking . . .", 3)
	
	await tween.finished
	
	await get_tree().create_timer(2).timeout
	tween = create_tween()
	tween.tween_property($Label4, "text", "There they lay. Resting . . .", 4)
	
	await tween.finished
	
	await get_tree().create_timer(3).timeout
	tween = create_tween().set_parallel(true)
	tween.tween_property($Label.label_settings, "font_color", Color(Color.WHITE, 0.0), 2)
	tween.tween_property($Label2.label_settings, "font_color", Color(Color.WHITE, 0.0), 2)
	tween.tween_property($Label3.label_settings, "font_color", Color(Color.WHITE, 0.0), 2)
	tween.tween_property($Label4.label_settings, "font_color", Color(Color.WHITE, 0.0), 2)
	
	await tween.finished
	$Label.text = ""
	$Label2.text = ""
	$Label3.text = ""
	$Label4.text = ""
	$Label.label_settings.font_color = Color.WHITE
	$Label2.label_settings.font_color = Color.WHITE
	$Label3.label_settings.font_color = Color.WHITE
	$Label4.label_settings.font_color = Color.WHITE
	
	tween = create_tween()
	tween.tween_property($TextureRect/Label, "text", "You get on your knees.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect/Label2, "text", "For the first time you accept what happened.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect/Label3, "text", "It was never your fault. Nor was it her fault.", 3.5)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect/Label4, "text", "You forgive yourself. You forgive her.", 2)
	
	await tween.finished
	
	await get_tree().create_timer(3).timeout
	tween = create_tween().set_parallel(true)
	tween.tween_property($TextureRect/Label.label_settings, "font_color", Color(Color.WHITE, 0.0), 2)
	tween.tween_property($TextureRect/Label2.label_settings, "font_color", Color(Color.WHITE, 0.0), 2)
	tween.tween_property($TextureRect/Label3.label_settings, "font_color", Color(Color.WHITE, 0.0), 2)
	tween.tween_property($TextureRect/Label4.label_settings, "font_color", Color(Color.WHITE, 0.0), 2)
	

	await tween.finished
	$TextureRect/Label.text = ""
	$TextureRect/Label2.text = ""
	$TextureRect/Label3.text = ""
	$TextureRect/Label4.text = ""
	$TextureRect/Label.label_settings.font_color = Color.WHITE
	$TextureRect/Label2.label_settings.font_color = Color.WHITE
	$TextureRect/Label3.label_settings.font_color = Color.WHITE
	$TextureRect/Label4.label_settings.font_color = Color.WHITE
	tween = create_tween()
	tween.tween_property($TextureRect2/Label, "text", "Your sister now awaits.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect2/Label2, "text", "She needs a role model. Someone to look after her.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect2/Label4, "text", "You decide to give your uncle a call. There's hope for a new beginning.", 3)
	
	await tween.finished
	
	await get_tree().create_timer(8).timeout
	
	$ColorRect.visible = true
	var tween2 = create_tween()
	tween2.tween_property($ColorRect/Credits, "text", "Credits
	
	Programmer: Mellow
	Artist: Anne
	Composer and Sound Designer: Liam
	Producer: Wen", 3)
	
	await tween2.finished
	
	await get_tree().create_timer(6).timeout
	tween2 = create_tween()
	tween2.tween_property($ColorRect/Credits, "position", Vector2(0, - 100), 10)
	
	await tween2.finished
	await get_tree().create_timer(10).timeout
	get_tree().quit()
