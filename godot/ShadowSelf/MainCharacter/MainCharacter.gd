class_name Player extends CharacterBody2D 

@export var speed : float = 60.0
var playerHasSelectedDirection : bool = false
var canMove : bool = true

func _ready() -> void:
	playIdle()
		
func _process(_delta)-> void:
	GlobalVariables.character_pos = global_position
	$SpriteColor.
	
func _input(event)-> void:
	if (event is InputEventMouseButton) and !playerHasSelectedDirection and canMove:
		$Label.show()
		$IdleText.hide()
		playerHasSelectedDirection = true
		
		var tween = create_tween()
		var pos = Vector2(get_global_mouse_position().x, self.position.y)
		if pos.x < self.position.x:
			flipSprites(true) # flip the sprite
		else:
			flipSprites(false) # dont flip the sprite
		
		playWalkCycle()
		tween.tween_property(self, "position", pos, 3.2).set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		playIdle()
		playerHasSelectedDirection = false
		$Label.hide()

# every 5 seconds, character will start wandering around
func _on_wander_timeout()-> void:
		if !playerHasSelectedDirection and canMove:
			$IdleText.show()
			#create tween
			var tween : Tween= create_tween()
			
			#choose a random direction everytime the timer ends
			var randomDirection = randi() % 2
			
			#random distance to walk
			var wander_distance : int = randi_range(50, 400)
			
			#current position of the character scene
			var pos : Vector2 = self.position

			match(randomDirection):
				0: # left
					flipSprites(true)
					# move the character in the x axis for a random ammount of pixels. duration is dependent on the distance. Start slow, go faster in the middle, end slow 
					tween.tween_property(self, "position", Vector2(pos.x - wander_distance, pos.y), 1.4).set_ease(Tween.EASE_IN_OUT)
					
				1: #right
					flipSprites(false)
					tween.tween_property(self, "position", Vector2(pos.x + wander_distance, pos.y), 1.4).set_ease(Tween.EASE_IN_OUT)
			
			playWalkCycle()
			await tween.finished
			playIdle()
			$IdleText.hide()

func playIdle()-> void:
	await get_tree().create_timer(0.3).timeout
	$SpriteOutline.play("idle")
	$SpriteColor.play("idle")	

func playWalkCycle()-> void:
	await get_tree().create_timer(0.3).timeout
	$SpriteOutline.play("walk_cycle")
	$SpriteColor.play("walk_cycle")	
	
func flipSprites(val: bool)-> void:
	$SpriteOutline.flip_h = val
	$SpriteColor.flip_h = val
