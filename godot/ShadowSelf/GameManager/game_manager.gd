extends Node2D

@export var room_level_scene : PackedScene
@export var outside_level_scene : PackedScene
@export var item_pickup : PackedScene
@onready var mainCharacter = $MainCharacter as Player
@onready var camera = $Camera2D
@onready var pause_menu = $MainCharacter/CanvasLayer/PauseMenu
@onready var pickup = $MainCharacter/CanvasLayer/ItemPickUp
@onready var alchemy = $MainCharacter/CanvasLayer/Alchemy
@onready var shadow = $Shadow
@onready var prompt = $MainCharacter/CanvasLayer/Prompt
@onready var prompt_yes = $MainCharacter/CanvasLayer/Prompt/Yes
@onready var prompt_no = $MainCharacter/CanvasLayer/Prompt/No
@onready var prompt_label = $MainCharacter/CanvasLayer/Prompt/Label
@onready var inventory = $MainCharacter/CanvasLayer/Inventory
@onready var fade_to_black = $Darken/ColorRect
var paused: bool = false
var alchemyToggled: bool = false

# Called when the node enters the scene tree for the first time.
func _ready()-> void:
	changeLevelToRoom(true)
	#changeLevelToOutside()
	prompt.hide()	

func _process(_delta)-> void:
	if Input.is_action_just_pressed("pause") and !alchemyToggled:
		pauseMenu()

#region spawn/despawn minigames
func spawnMinigame(minigame_scene: PackedScene)-> void:
	mainCharacter.canMove = false
	await animateSpawn()
	var minigame = minigame_scene.instantiate() as Minigame
	minigame.minigameIsFinished.connect($".".despawnMinigame.bind())
	minigame.global_position = GlobalVariables.character_pos + Vector2(0, -800)

	mainCharacter.add_child(minigame)

func despawnMinigame()-> void:
	mainCharacter.canMove = true
	for idx in $MainCharacter.get_children():
		if idx is Minigame:
			idx.queue_free()	
			
	animateDespawn()
			
func animateSpawn()-> void:
	$Shadow.hide()
	$ShadowLink.hide()
	var cameraZoom = $Camera2D.zoom
	var tween : Tween = create_tween().set_parallel(true)
	tween.tween_property($Camera2D, "offset", Vector2(0, -200), 4.2)
	tween.tween_property($Camera2D, "zoom", cameraZoom - Vector2(0.1, 0.1), 4.2)
	await tween.finished
	
func animateDespawn()-> void:
	var tween : Tween = create_tween().set_parallel(true)
	var cameraZoom = $Camera2D.zoom
	tween.tween_property($Camera2D, "offset", Vector2(0, 0), 1)
	tween.tween_property($Camera2D, "zoom", cameraZoom + Vector2(0.1, 0.1), 1)
	await tween.finished
	$Shadow.show()
	$ShadowLink.show()
	
#endregion

func fadeToBlack():
	var tween : Tween = create_tween()
	
	fade_to_black.modulate = Color.BLACK
	tween.tween_property(fade_to_black, "color", Color.BLACK, 2)
	await tween.finished
	
func fadeIn():
	var tween : Tween = create_tween()
	await get_tree().create_timer(1.0).timeout
	tween = create_tween()
	tween.tween_property(fade_to_black, "color", Color.TRANSPARENT, 4)
	
	await get_tree().create_timer(1).timeout
	
#region change levels
func changeLevelToOutside()-> void:
	mainCharacter.canMove = false
	mainCharacter.global_position = Vector2(200, 500)
	camera.zoom = Vector2(0.5, 0.5)
	
	await fadeToBlack()
	
	var level = outside_level_scene.instantiate()
	level.spawnMinigame.connect($".".spawnMinigame.bind())
	level.goInside.connect($".".changeLevelToRoom.bind())
	level.prompt.connect($".".spawnPrompt.bind())
	add_child(level)
	
	for idx in self.get_children():
		if idx is RoomLevel:
			idx.queue_free()	

	mainCharacter.canMove = true
	await fadeIn()
	#TODO
	#center screen
	#make character smaller
	
func changeLevelToRoom(firstTime: bool)-> void:
	mainCharacter.canMove = false
	camera.zoom = Vector2(0.8, 0.8)
	if (!firstTime):
		mainCharacter.global_position = Vector2(2157.151, 381)
		
	var level = room_level_scene.instantiate()
	level.spawnMinigame.connect($".".spawnMinigame.bind())
	level.goOutside.connect($".".changeLevelToOutside.bind())
	level.prompt.connect($".".spawnPrompt.bind())
	level.findItem.connect($".".itemPickedUp.bind())
	add_child(level)
	
	await fadeToBlack()
	for idx in self.get_children():
		if idx is OutsideLevel:
			idx.queue_free()	
	
	await fadeIn()
	mainCharacter.canMove = true
#endregion

func pauseMenu():
	if GlobalVariables.paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
	GlobalVariables.paused = paused
	inventory.hide()

func _on_pause_menu_resume(): 
	pauseMenu()


func _on_pause_menu_quit():
	get_tree().quit()

func spawnPrompt(stri : String, object: String):
	if mainCharacter.canMove:
		GlobalVariables.paused = true
		prompt.name = object
		if prompt.name  == "door":
			prompt_no.hide()
			prompt_yes.text = "Ok"
		else:
			prompt_no.show()
			prompt_yes.text = "Yes"
		
		prompt_label.text = stri 
		prompt.show()
		Engine.time_scale = 0.0
		
func _on_prompt_yes():
	prompt.hide()
	GlobalVariables.paused = false
	Engine.time_scale = 1.0

	if prompt.name == "mirror":
		alchemyToggle()
	
	if prompt.name == "outside":
		changeLevelToOutside()

func _on_prompt_no():
	if prompt.visible:
		prompt.hide()
		GlobalVariables.paused = false
		Engine.time_scale = 1

func alchemyToggle():
	if alchemyToggled:
		alchemy.hide()
		shadow.show()
		mainCharacter.canMove = true
		Engine.time_scale = 1
		GlobalVariables.paused = false
	else:
		mainCharacter.canMove = false
		spawnAlchemyMenu()
		GlobalVariables.paused = true
		
	alchemyToggled = !alchemyToggled

func _on_alchemy_quit():
	alchemyToggle()

func spawnAlchemyMenu():
	alchemy.modulate = Color.TRANSPARENT
	alchemy.show()
	alchemy.update_sprites()
	shadow.hide()
	var tween : Tween = create_tween()
	tween.tween_property(alchemy, "modulate", Color.WHITE, 2)
	await tween.finished

func itemPickedUp(item: String):
	if item not in GlobalVariables.inventory:
		GlobalVariables.inventory.push_front(item)
	
	pickup.itemName = item
	pickup.set_sprite()
	pickup.show()
	Engine.time_scale = 0.0

func closePickUpFunc():
	pickup.hide()
	Engine.time_scale = 1.0

func _on_pause_menu_show_inventory():
	toggleInventory()
	
func toggleInventory():
	if !inventory.visible:
		inventory.update_sprites()
		inventory.show()
	else:
		inventory.hide()


func _on_alchemy_give_nostalgia():
	itemPickedUp("NostalgicMemory")
	GlobalVariables.trees_unlocked.push_back("Past")

func _on_alchemy_give_reality():	
	itemPickedUp("RealityMemory")
	GlobalVariables.trees_unlocked.push_back("Present")

func _on_alchemy_give_responsability():	
	itemPickedUp("ResponsabilityMemory")
	GlobalVariables.trees_unlocked.push_back("Future")

