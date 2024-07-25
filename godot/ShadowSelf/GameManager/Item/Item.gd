class_name Item extends Sprite2D

@onready var item_name = $Name
@onready var desc = $Description
var item_category
var draggable = false
var is_inside_dropable = false
var body_ref : AlchemySpot
var initialPos :Vector2
var actual_initialPos :Vector2
var exited :=false
@export var skip = false

signal checkCombinations
func _ready():
	actual_initialPos = global_position
	update()

func _process(delta):
	if draggable and !skip:
		if Input.is_action_just_pressed("leftclick"):
			initialPos = global_position
			GlobalVariables.isDragging = true
			
		if Input.is_action_pressed("leftclick"):
			global_position = get_global_mouse_position() 
		elif Input.is_action_just_released("leftclick"):
			GlobalVariables.isDragging = false
			var tween = create_tween()
			if is_inside_dropable:
				tween.tween_property(self, "global_position", body_ref.global_position + Vector2(40,40), 0.2).set_ease(Tween.EASE_OUT)
				body_ref.occupied = true
				body_ref.itemCategory = item_category
				body_ref.updateSprite()
				checkCombinations.emit()
				skip = true
			else: 
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)
				
func _on_area_2d_mouse_entered():
	if (item_name.text != ""):
		var parent = get_parent().name
		var index : int = 0
		
		if GlobalVariables.trees_unlocked.any(func(stri): return stri == parent):
			index = 1
		
		desc.text = str(GlobalVariables.itemAttr[$".".name][index])
	
	if not GlobalVariables.isDragging:
		draggable = true
		scale += Vector2(0.01, 0.01)
		
func _on_area_2d_mouse_exited():
	desc.text = ""
	
	if not GlobalVariables.isDragging:
		draggable = false
		scale -= Vector2(0.01, 0.01)

func update():
	if GlobalVariables.inventory.any(func(stri): return stri == str($".".name)):
		item_name.text = str($".".name)
		item_category = GlobalVariables.itemAttr[str($".".name)][2]

func _on_area_2d_body_entered(body):
	if body.is_in_group("dropable"):		
		if !body.occupied:
			is_inside_dropable = true 
			body.modulate = Color(Color.REBECCA_PURPLE, 1)
			body_ref = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("dropable"):
		is_inside_dropable = false 
		body.modulate = Color(Color.MEDIUM_PURPLE, 1)
		exited = true

func hideName():
	item_name.text = ""
	
func showName():
	update()
