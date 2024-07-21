extends CharacterBody2D

@export var speed : int = 60.0
var playerHasSelectedDirection : bool = false
var canSelectDirection : bool = true

func _input(event):
	if (event is InputEventMouseButton) and canSelectDirection:
		playerHasSelectedDirection = true
		self.modulate = Color.AQUA
		var tween = create_tween()
		var pos = Vector2(event.position.x, self.position.y)
		
		if pos.x < self.position.x:
			tween.tween_property($Sprite2D, "flip_h", true, 1) # flip the sprite
		else:
			tween.tween_property($Sprite2D, "flip_h", false, 1) # dont flip the sprite
			
		tween.tween_property(self, "position", pos, 4).set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		self.modulate = Color.WHITE
		playerHasSelectedDirection = false

# every 5 seconds, character will start wandering around
func _on_wander_timeout():
	if !playerHasSelectedDirection:
		
		canSelectDirection = false
		#create tween
		var tween : Tween= create_tween()
		
		#choose a random direction everytime the timer ends
		var randomDirection = randi() % 2
		
		#random distance to walk
		var distance : int = randi_range(50, 200)
		
		#current position of the character scene
		var pos : Vector2 = self.position

		match(randomDirection):
			0: # left
				tween.tween_property($Sprite2D, "flip_h", true, 0.5) # flip the sprite
				# move the character in the x axis for a random ammount of pixels. duration is dependent on the distance. Start slow, go faster in the middle, end slow 
				tween.tween_property(self, "position", Vector2(pos.x - distance, pos.y), 2).set_ease(Tween.EASE_IN_OUT)
			
			1: #right
				tween.tween_property($Sprite2D, "flip_h", false, 0.5)
				tween.tween_property(self, "position", Vector2(pos.x + distance, pos.y), 2).set_ease(Tween.EASE_IN_OUT)
	
		await tween.finished
		canSelectDirection = true
