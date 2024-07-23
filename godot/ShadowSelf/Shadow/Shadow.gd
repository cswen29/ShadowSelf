extends CharacterBody2D

@onready var sero_counter = $"../CanvasLayer/SeroCounter"
@onready var dopa_counter = $"../CanvasLayer/DopaCounter"
@onready var endo_counter = $"../CanvasLayer/EndoCounter"
@onready var animation_player = $AnimationPlayer
var has_obj:bool = false
var drop_zone:bool = false

func _ready():
	var playspeed = randf_range(2.0,3.5)
	animation_player.play("ShadowBody",-1,playspeed)

func _physics_process(_delta):
	var tween = create_tween()
	tween.tween_property(self,"position",get_global_mouse_position(),0.1)
	move_and_slide()

func _input(event):
	if event.is_action_pressed("leftclick"):
		if sero_counter.hover_me or dopa_counter.hover_me or endo_counter.hover_me:
			if not has_obj:
				var object = preload("res://assets/Blink/Blink.tscn")
				var new_obj = object.instantiate()
				add_child(new_obj)
				has_obj = true
		elif has_obj:
			if drop_zone:
				for child in get_children():
					if child is Sprite2D:
						child.queue_free()


func _on_alch_drop_1_mouse_entered():
	drop_zone = true
	if has_obj:
		print("Drop zone has obj!")
	else:
		print("Drop zone!")

