extends Node2D

@export var room_level_scene : PackedScene
@export var outside_level_scene : PackedScene
@onready var mainCharacter = $MainCharacter as Player

# Called when the node enters the scene tree for the first time.
func _ready()-> void:
	changeLevelToRoom()

#region spawn/despawn minigames
func spawnMinigame(minigame_scene: PackedScene)-> void:
	mainCharacter.canMove = false
	var minigame = minigame_scene.instantiate() as Minigame
	minigame.minigameIsFinished.connect($".".despawnMinigame.bind())
	call_deferred("add_child", minigame)
	
	var minigame_position : Vector2 = minigame.position
	animateSpawn(minigame_position)
	
func despawnMinigame()-> void:
	mainCharacter.canMove = true
	for idx in self.get_children():
		if idx is Minigame:
			idx.queue_free()	
			
	animateDespawn()
			
func animateSpawn(minigame_position: Vector2)-> void:
	$Shadow.hide()
	$ShadowLink.hide()
	var cameraZoom = $MainCharacter/Camera2D.zoom
	var tween : Tween = create_tween().set_parallel(true)
	tween.tween_property($MainCharacter/Camera2D, "offset", minigame_position, 3)
	tween.tween_property($MainCharacter/Camera2D, "zoom", cameraZoom - Vector2(0.2, 0.2), 3)
	await tween.finished
	
func animateDespawn()-> void:
	var tween : Tween = create_tween().set_parallel(true)
	var cameraZoom = $MainCharacter/Camera2D.zoom
	tween.tween_property($MainCharacter/Camera2D, "offset", Vector2(0, 0), 1)
	tween.tween_property($MainCharacter/Camera2D, "zoom", cameraZoom + Vector2(0.2, 0.2), 1)
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
