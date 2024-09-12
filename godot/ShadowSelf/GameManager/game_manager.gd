extends Node2D

@export var room_level_scene : PackedScene
@export var outside_level_scene : PackedScene
@export var item_pickup : PackedScene
@export var gameOver_scene : PackedScene
@export var ending : PackedScene
@onready var mainCharacter = $MainCharacter as Player
@onready var camera = $Camera2D
@onready var pause_menu = $MainCharacter/CanvasLayer/PauseMenu
@onready var pickup = $MainCharacter/CanvasLayer/ItemPickUp
@onready var alchemy = $MainCharacter/CanvasLayer/Alchemy
@onready var shadow = $Shadow
@onready var prompt = $MainCharacter/CanvasLayer/Prompt
@onready var prompt_yes = $MainCharacter/CanvasLayer/Prompt/Yes
@onready var prompt_no = $MainCharacter/CanvasLayer/Prompt/No
@onready var prompt_label = $MainCharacter/CanvasLayer/Prompt/Background/Label
@onready var fade_to_black = $Darken/ColorRect
var paused: bool = false
var alchemyToggled: bool = false
@onready var transition = $Transition
var room_level_instance
var outside_level_instance

# Called when the node enters the scene tree for the first time.
func _ready()-> void:
	room_level_instance = room_level_scene.instantiate()
	outside_level_instance = outside_level_scene.instantiate()
	room_level_instance.prompt.connect($".".spawnPrompt.bind())
	outside_level_instance.prompt.connect($".".spawnPrompt.bind())
	$Transition/CanvasLayer/BlackBackground.visible = true
	changeLevelToRoom(true)
	#changeLevelToOutside()
	prompt.hide()	
	$MainCharacter/CanvasLayer/PlayerHealth.size = Vector2(40,40)
	Engine.time_scale = 1.0
	getFadeIntensity(0)

func _process(_delta):
	$Limit.position = shadow.position
	
#region change levels
func changeLevelToOutside()-> void:
	var shadowScale = shadow.scale
	mainCharacter.changeFootstepsToOutside()
	mainCharacter.canMove = false
	mainCharacter.global_position = Vector2(-7340.433, 500)
	camera.zoom = Vector2(0.5, 0.5)
	camera.limit_bottom = 10000000
	camera.limit_right = 22075
	camera.limit_top = -10000000
	camera.limit_left = -17000
	var level = outside_level_instance
	add_child(level)
	
	for child in self.get_children(true):
		if child is RoomLevel:
			remove_child(child)
			
	for idx in self.get_children():
		if idx is RoomLevel:
			idx.queue_free()	

	mainCharacter.canMove = true
	transition.play("fade_in")
	shadow.scale = shadowScale
	
func changeLevelToRoom(firstTime: bool)-> void:
	mainCharacter.canMove = false
	var shadowScale = shadow.scale
	mainCharacter.changeFootstepsToRoom()
	
	await get_tree().create_timer(2).timeout
	transition.play("fade_in")
	camera.zoom = Vector2(0.8, 0.8)
	camera.limit_bottom = 1015
	camera.limit_right = 2770
	camera.limit_top = -680
	camera.limit_left = -350
	var level = room_level_instance
	for child in self.get_children(true):
		if child is OutsideLevel:
			remove_child(child)
	
	add_child(level)
	
	if (!firstTime):
		mainCharacter.position = Vector2(2157.151, 381)
	mainCharacter.canMove = true
	shadow.scale = shadowScale
	
	
#endregion

#alchemy and prompts
func spawnPrompt(stri : String, object: String):
	if mainCharacter.canMove:
		prompt.spawn(stri, object)

func _on_prompt_yes():
	if prompt.name == "mirror":
		spawnAlchemyMenu()
	
	if prompt.name == "outside":
		transition.play("fade_out")
		mainCharacter.canMove = false
		$SFX/DoorSlide.play()
		await transition.animation_finished
		changeLevelToOutside()
		
	if prompt.name == "shelf":
		itemPickedUp("PictureOfFamily")
		
	if prompt.name == "tree":
		itemPickedUp("Tree")
	
	if prompt.name == "bridge":
		itemPickedUp("BridgePebbles")
	
	if prompt.name == "watch":
		itemPickedUp("Watch")
	
	if prompt.name == "letter":
		itemPickedUp("CollegeLetter")
	
	if prompt.name == "icecream":
		itemPickedUp("IceCream")
	
	if prompt.name == "flower":
		itemPickedUp("Flower")
		
	if prompt.name == "gameboy":
		itemPickedUp("Gameboy")
		
	if prompt.name == "inside":
		for child in self.get_children(true):
			if child is OutsideLevel:
				changeLevelToRoom(false)
				break
			if child is RoomLevel:
				changeLevelToOutside()
				break
		

func _on_alchemy_quit():
	mainCharacter.canMove = true
	shadow.show()

func spawnAlchemyMenu():
	mainCharacter.canMove = false	
	mainCharacter.playIdle()
	alchemy.spawn()
	shadow.hide()
	
#endregion

#region item pick up
func itemPickedUp(item: String):
	if item not in GlobalVariables.inventory:
		if GlobalVariables.inventory.size() == 3:
			mainCharacter.updateSprite(1)
			animateFadeIntesity(1)
		if GlobalVariables.inventory.size() == 5:
			$Music/Layer2.volume_db = -1
			mainCharacter.updateSprite(2)
			animateFadeIntesity(2)
		if GlobalVariables.inventory.size() == 7:
			$Music/Layer3.volume_db = -1
			mainCharacter.updateSprite(3)
			animateFadeIntesity(3)
			
		$MainCharacter.health = 10
		$MainCharacter/CanvasLayer/PlayerHealth.size = Vector2(40,40)
		pickup.pickedUpItem(item)

func _on_alchemy_give_responsability():	
	if "Future" not in GlobalVariables.trees_unlocked:
		itemPickedUp("ResponsabilityMemory")
		GlobalVariables.trees_unlocked.push_back("Future")
		shadow.scale = shadow.scale - Vector2(0.5, 0.5)
		
func _on_alchemy_give_nostalgia():
	if "Past" not in GlobalVariables.trees_unlocked:
		itemPickedUp("NostalgicMemory")
		GlobalVariables.trees_unlocked.push_back("Past")
		shadow.scale = shadow.scale - Vector2(0.5, 0.5)
		if GlobalVariables.trees_unlocked.size() == 3:
			win()

func _on_alchemy_give_reality():	
	if "Present" not in GlobalVariables.trees_unlocked:
		itemPickedUp("RealityMemory")
		GlobalVariables.trees_unlocked.push_back("Present")
		shadow.scale = shadow.scale - Vector2(0.5, 0.5)
		if GlobalVariables.trees_unlocked.size() == 3:
			win()

func win():
	await get_tree().create_timer(10).timeout
	transition.play("fade_out")
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_packed(ending)
	
#region screen fade according to memories found	
func animateFadeIntesity(num : int):
	var tween = create_tween()
	tween.tween_property(fade_to_black, "color", Color(getFadeIntensity(num)), 0.5)
	
func getFadeIntensity(num: int) -> String:
	var color = ""
	match (num):
		0: 
			color = "000000ad"
		1:
			color = "00000072"
		2:
			color = "0000004c"
		3:
			color = "00000000"
	return color
#endregion

func _on_main_character_player_hit(hp):
	if (hp == 0):
		gameOver("You negative thoughts were too strong.")
	
	$MainCharacter/CanvasLayer/PlayerHealth.size = Vector2(4 * hp, 40)
	
func _on_shadow_shadow_eat():
	shadow.scale = shadow.scale + Vector2(0.02, 0.02)
	if shadow.scale > Vector2(1.5, 1.5):
		var tween = create_tween()
		tween.tween_property(shadow, "modulate", Color.YELLOW, 0.1)
		tween.tween_property(shadow, "modulate", Color.BLACK, 0.1)
	
	if shadow.scale > Vector2(1.8, 1.8):
		var tween = create_tween()
		tween.tween_property(shadow, "modulate", Color.RED, 0.1)
		tween.tween_property(shadow, "modulate", Color.BLACK, 0.1)
		
	if shadow.scale > Vector2(2, 2):
		gameOver("Your shadow grew too big and consumed you.")
	
func gameOver(text):
	Engine.time_scale = 0.0
	GlobalVariables.paused = true
	$MainCharacter/CanvasLayer/GameOver/Label2.text = text
	$MainCharacter/CanvasLayer/GameOver.show()
	
func on_game_over_retry():
	Engine.time_scale = 1.0
	$MainCharacter/CanvasLayer/GameOver.hide()
	GlobalVariables.paused = false
	get_tree().reload_current_scene()
