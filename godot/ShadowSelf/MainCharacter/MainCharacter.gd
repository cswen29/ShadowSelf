class_name Player extends CharacterBody2D 

@export var speed : float = 60.0
var playerHasSelectedDirection : bool = false
var canMove : bool = true
var health = 10
var array = [1, 2, 3, 4, 5]
signal playerHit
var isOutside
var walking = false

func _ready() -> void:
	updateSprite(0)
	playIdle()
		
func _process(_delta)-> void:
	GlobalVariables.character_pos = global_position	
	
func _input(event)-> void:
		if (event is InputEventMouseButton) and canMove and !playerHasSelectedDirection:
			$Label.show()
			$IdleText.hide()
			playerHasSelectedDirection = true
			
			var pos = Vector2(get_global_mouse_position().x, self.position.y)
			if pos.x < self.position.x:
				flipSprites(true) # flip the sprite
			else:
				flipSprites(false) # dont flip the sprite
			
			playWalkCycle()
			if GlobalVariables.playerOffLimitsRight:
				if pos.x > self.position.x:
					playerHasSelectedDirection = false
					$Label.hide()
					return
					
			if GlobalVariables.playerOffLimitsLeft:
				if pos.x < self.position.x:
					playerHasSelectedDirection = false
					$Label.hide()
					return
					
			var tween = create_tween()
			tween.tween_property(self, "position", pos, 3).set_ease(Tween.EASE_IN_OUT)
			await tween.finished
			playIdle()
			playerHasSelectedDirection = false
			$Label.hide()

# every 5 seconds, character will start wandering around
func _on_wander_timeout()-> void:
	if !GlobalVariables.playerOffLimitsRight or !GlobalVariables.playerOffLimitsLeft:
		if !playerHasSelectedDirection and canMove:
			$IdleText.show()
			
			#choose a random direction everytime the timer ends
			var randomDirection = randi() % 2
			
			#random distance to walk
			var wander_distance : int = randi_range(50, 400)
			
			#current position of the character scene
			var pos : Vector2 = self.position
			
			#create tween
			var tween : Tween= create_tween()
			
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
			#playIdle()
			$IdleText.hide()

func playIdle()-> void:
		walking = false
		$SpriteOutline.play("idle")
		if ($SpriteOutline.flip_h):
			$SpriteOutline.position =  Vector2(-50,0)
		else: 
			$SpriteOutline.position =  Vector2(50,0)
			
		$SpriteColor.play("idle")	

func playWalkCycle()-> void:				
	walking = true
	$SpriteOutline.play("walk_cycle")
	$SpriteOutline.position =  Vector2(0,0)
	$SpriteColor.play("walk_cycle")	
	
func flipSprites(val: bool)-> void:
	$SpriteOutline.flip_h = val
	$SpriteColor.flip_h = val

func updateSprite(number : int) -> void:
	var color = "5e5e5e"
	match (number):
		0: 
			color = "292929"
		1: 
			color = "5e5e5e"
		2:
			color = "8c8c8c"
		3:
			color = "ffffff"

	var tween = create_tween()
	tween.tween_property($SpriteColor, "modulate", Color(color), 5)

func _on_area_2d_body_entered(body):
	if body is Thoughts:
		health -= 1
		playerHit.emit(health)
		$SFX/PlayerHit.play()

func changeFootstepsToOutside():
	isOutside = true
	
func changeFootstepsToRoom():
	isOutside = false

func _on_footsteps_timer_timeout():
	if (walking):
		var sound = array.pick_random()
		var stri = "SFX/Footsteps"

		if isOutside:
			stri = str(stri, "Outside", sound)
		else:
			stri = str(stri, "Inside", sound)
		
		var node = get_node(stri) as AudioStreamPlayer
		node.play()		
