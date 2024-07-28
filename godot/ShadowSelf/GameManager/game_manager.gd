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
@onready var fade_to_black = $Darken/ColorRect
var paused: bool = false
var alchemyToggled: bool = false
@onready var transition = $Transition

# Called when the node enters the scene tree for the first time.
func _ready()-> void:
	changeLevelToRoom(true)
	#changeLevelToOutside()
	prompt.hide()	
	
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

#region change levels
func changeLevelToOutside()-> void:
	mainCharacter.canMove = false
	mainCharacter.global_position = Vector2(200, 500)
	camera.zoom = Vector2(0.5, 0.5)
	
	var level = outside_level_scene.instantiate()
	level.spawnMinigame.connect($".".spawnMinigame.bind())
	level.goInside.connect($".".changeLevelToRoom.bind())
	level.prompt.connect($".".spawnPrompt.bind())
	add_child(level)
	
	for idx in self.get_children():
		if idx is RoomLevel:
			idx.queue_free()	

	mainCharacter.canMove = true
	transition.play("fade_in")
	
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
	
	for idx in self.get_children():
		if idx is OutsideLevel:
			idx.queue_free()	

	mainCharacter.canMove = true
	transition.play("fade_in")
	await transition.animation_finished
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
		$SFX/DoorSlide.play()
		await transition.animation_finished
		changeLevelToOutside()
		
	if prompt.name == "shelf":
		itemPickedUp("PictureOfFamily")

func _on_alchemy_quit():
	mainCharacter.canMove = true
	shadow.show()

func spawnAlchemyMenu():
	mainCharacter.canMove = false	
	alchemy.spawn()
	shadow.hide()
	
#endregion

#region item pick up
func itemPickedUp(item: String):
	if item not in GlobalVariables.inventory:
		pickup.pickedUpItem(item)

func _on_alchemy_give_responsability():	
	if "Future" not in GlobalVariables.trees_unlocked:
		itemPickedUp("ResponsabilityMemory")
		GlobalVariables.trees_unlocked.push_back("Future")
		mainCharacter.updateSprite()
		for i in 8:
			await get_tree().create_timer(1).timeout
			$Music/Layer2.volume_db += db_to_linear(10)
		
func _on_alchemy_give_nostalgia():
	if "Past" not in GlobalVariables.trees_unlocked:
		itemPickedUp("NostalgicMemory")
		GlobalVariables.trees_unlocked.push_back("Past")
		mainCharacter.updateSprite()
		animateFadeIntesity()
		for i in 8:
			await get_tree().create_timer(1).timeout
			$Music/Layer3.volume_db += db_to_linear(10)

func _on_alchemy_give_reality():	
	if "Present" not in GlobalVariables.trees_unlocked:
		itemPickedUp("RealityMemory")
		GlobalVariables.trees_unlocked.push_back("Present")
		mainCharacter.updateSprite()
		animateFadeIntesity()
		$Music/Layer2.volume_db += db_to_linear(10)
		$Music/Layer3.volume_db += db_to_linear(10)

#region screen fade according to memories found	
func animateFadeIntesity():
	var tween = create_tween()
	tween.tween_property(fade_to_black, "color", Color(getFadeIntensity()), 2)
	
func getFadeIntensity() -> String:
	var numberOfTrees := GlobalVariables.trees_unlocked.size()
	var color = ""
	match (numberOfTrees):
		0: 
			color = "0000008e"
		1:
			color = "00000041"
		2:
			color = "00000020"
		3:
			color = "00000000"
	return color
#endregion
