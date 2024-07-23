extends Node2D

@export var room_level_scene : PackedScene
@export var outside_level_scene : PackedScene
@onready var mainCharacter = $MainCharacter as Player
@onready var camera = $Camera2D
@onready var pause_menu = $Camera2D/PauseMenu
var paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready()-> void:
	changeLevelToRoom()

func _process(_delta)-> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

#region spawn/despawn minigames
func spawnMinigame(minigame_scene: PackedScene)-> void:
	mainCharacter.canMove = false
	await animateSpawn()
	var minigame = minigame_scene.instantiate() as Minigame
	minigame.minigameIsFinished.connect($".".despawnMinigame.bind())
	minigame.global_position = GlobalVariables.character_pos + Vector2(0, -800)

	call_deferred("add_child", minigame)

func despawnMinigame()-> void:
	mainCharacter.canMove = true
	for idx in self.get_children():
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
	var level = outside_level_scene.instantiate()
	level.spawnMinigame.connect($".".spawnMinigame.bind())
	level.goInside.connect($".".changeLevelToRoom.bind())
	add_child(level)
	
	for idx in self.get_children():
		if idx is RoomLevel:
			idx.queue_free()	
	
	await get_tree().create_timer(6).timeout
	mainCharacter.canMove = true
	
func changeLevelToRoom()-> void:
	mainCharacter.canMove = false
	var level = room_level_scene.instantiate()
	level.spawnMinigame.connect($".".spawnMinigame.bind())
	level.goOutside.connect($".".changeLevelToOutside.bind())
	add_child(level)
	
	for idx in self.get_children():
		if idx is OutsideLevel:
			idx.queue_free()	
	
	await get_tree().create_timer(6).timeout
	mainCharacter.canMove = true
#endregion

func pauseMenu():
	print("pause")
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused

func _on_pause_menu_resume(): 
	pauseMenu()

func _on_pause_menu_quit():
	get_tree().quit()
