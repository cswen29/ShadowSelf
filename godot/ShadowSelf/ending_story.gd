extends TextureRect

var simultaneous_scene = preload("res://GameManager/game_manager.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
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
	tween.tween_property($Label2, "text", "You walk slowly pass the bridge you used to play with your dad.", 2.5)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($Label3, "text", "You keep walking. . .", 3)
	
	await tween.finished
	
	await get_tree().create_timer(2).timeout
	tween = create_tween()
	tween.tween_property($Label4, "text", "There they lay. Resting.", 2)
	
	await tween.finished
	
	await get_tree().create_timer(3).timeout
	tween = create_tween().set_parallel(true)
	tween.tween_property($Label, "text", "", 2)
	tween.tween_property($Label2, "text", "", 2)
	tween.tween_property($Label3, "text", "", 2)
	tween.tween_property($Label4, "text", "", 2)
	
	await tween.finished

	tween = create_tween()
	tween.tween_property($TextureRect/Label, "text", "You get on your knees.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect/Label2, "text", "For the first time you accept what happened", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect/Label3, "text", "It was never your fault. Nor hers.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect/Label4, "text", "You forgive youself and her.", 2)
	
	await tween.finished
	
	await get_tree().create_timer(3).timeout
	tween = create_tween().set_parallel(true)
	tween.tween_property($TextureRect/Label, "text", "", 2)
	tween.tween_property($TextureRect/Label2, "text", "", 2)
	tween.tween_property($TextureRect/Label3, "text", "", 2)
	tween.tween_property($TextureRect/Label4, "text", "", 2)
	
	await tween.finished

	tween = create_tween()
	tween.tween_property($TextureRect2/Label, "text", "Your sister now awaits.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect2/Label2, "text", "She needs a role model. Someone to look after her.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect2/Label4, "text", "You decide to give your uncle a call. You hope he let's you take care of her.", 2)
	
	await tween.finished
	
	await get_tree().create_timer(5).timeout
	
	get_tree().change_scene_to_packed(simultaneous_scene)
