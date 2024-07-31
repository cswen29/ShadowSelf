extends TextureRect

var simultaneous_scene = preload("res://GameManager/game_manager.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$SFX/Ambience.play()
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
	tween.tween_property($Label, "text", "You're alone.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($Label2, "text", "Negative thoughts and regrets are all you have.", 2.5)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($Label3, "text", "Despite that, some old items bring relief to your pain.", 2.5)
	
	await tween.finished
	
	await get_tree().create_timer(1).timeout
	tween = create_tween()
	tween.tween_property($Label4, "text", "Find these items, cherish your memories.", 2)
	
	await tween.finished
	
	await get_tree().create_timer(3).timeout
	tween = create_tween().set_parallel(true)
	tween.tween_property($Label, "text", "", 1)
	tween.tween_property($Label2, "text", "", 1)
	tween.tween_property($Label3, "text", "", 1)
	tween.tween_property($Label4, "text", "", 1)
	
	await tween.finished

	tween = create_tween()
	tween.tween_property($TextureRect/Label, "text", "Your thoughts will fight you.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect/Label2, "text", "Your shadow, lord of all unconscious, will protect you.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect/Label3, "text", "If your thoughts touch you, you get closer to giving up.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect/Label4, "text", "If your shadow gets too big, you get closer to giving up.", 2)
	
	await tween.finished
	
	await get_tree().create_timer(3).timeout
	tween = create_tween().set_parallel(true)
	tween.tween_property($TextureRect/Label, "text", "", 1)
	tween.tween_property($TextureRect/Label2, "text", "", 1)
	tween.tween_property($TextureRect/Label3, "text", "", 1)
	tween.tween_property($TextureRect/Label4, "text", "", 1)
	
	await tween.finished

	tween = create_tween()
	tween.tween_property($TextureRect2/Label, "text", "Remember who you are.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect2/Label2, "text", "Remember your family.", 2)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property($TextureRect2/Label4, "text", "~Transform~ those bad memories into your strength.", 2)
	
	await tween.finished
	
	await get_tree().create_timer(5).timeout
	
	get_tree().change_scene_to_packed(simultaneous_scene)
	return
	
