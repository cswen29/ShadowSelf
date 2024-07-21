extends CharacterBody2D

@export var speed : float = 60.0
var playerHasSelectedDirection : bool = false
var canSelectDirection : bool = true
var canMove : bool = true
@onready var floaty = $"../PlayerBodyTest"
@onready var line = $ShadowLink
var tether_distance
var idle:bool = true

func _input(event):
	if (event is InputEventMouseButton) and canSelectDirection and canMove:
		playerHasSelectedDirection = true
		
		var tween = create_tween()
		var pos = Vector2(get_global_mouse_position().x, self.position.y)

		if pos.x < self.position.x:
			$SpriteOutline.flip_h = true # flip the sprite
			
			$SpriteColor.flip_h = true # flip the sprite
		else:
			$SpriteOutline.flip_h = false # dont flip the sprite
			$SpriteColor.flip_h = false # dont flip the sprite
		
		$SpriteOutline.play("walk_cycle")	
		$SpriteColor.play("walk_cycle")	
		tween.tween_property(self, "position", pos, 4).set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		await get_tree().create_timer(0.3).timeout
		$SpriteOutline.play("idle")
		$SpriteColor.play("idle")	
		playerHasSelectedDirection = false

# every 5 seconds, character will start wandering around
func _on_wander_timeout():
	if !playerHasSelectedDirection and canMove:
		canSelectDirection = false
		#create tween
		var tween : Tween = create_tween()
		
		#choose a random direction everytime the timer ends
		var randomDirection = randi() % 2
		
		#random distance to walk
		var distance : int = randi_range(50, 200)
		
		#current position of the character scene
		var pos : Vector2 = self.position

		match(randomDirection):
			0: # left
				$SpriteOutline.flip_h = true # flip the sprite
				$SpriteOutline.play("walk_cycle")	
				$SpriteColor.flip_h = true # flip the sprite
				$SpriteColor.play("walk_cycle")	
				# move the character in the x axis for a random ammount of pixels. duration is dependent on the distance. Start slow, go faster in the middle, end slow 
				tween.tween_property(self, "position", Vector2(pos.x - distance, pos.y), 2).set_ease(Tween.EASE_IN_OUT)
			
			1: #right
				$SpriteOutline.flip_h = false # flip the sprite
				$SpriteOutline.play("walk_cycle")
				$SpriteColor.flip_h = false # flip the sprite
				$SpriteColor.play("walk_cycle")
				tween.tween_property(self, "position", Vector2(pos.x + distance, pos.y), 2).set_ease(Tween.EASE_IN_OUT)
		
		await tween.finished
		await get_tree().create_timer(0.3).timeout
		$SpriteOutline.play("idle")
		$SpriteColor.play("idle")
		canSelectDirection = true

func _physics_process(_delta):
	tether_distance = abs(self.global_position.x - floaty.global_position.x) + abs(self.global_position.y - floaty.global_position.y)
	if tether_distance >= 800:
		line.hide()
	else:
		line.show()
	line.width=20
	line.width=line.width+(-tether_distance/50)
