extends Node2D

#################################
# RESPONSIBILITIES
#
# 1. Set sprite                     [ ]
# 2. Set sounds                     [ ]
# 3. Listen for mouse / drag events [ ]
# 4. Adjust position                [ ]
# 5. Signal entering collision      [ ]
# 
#################################

# Manually assign type in editor or code if needed
@export var type: String = ""

var ingredient_types: Array = [
	"DeathPotion",
	"Vanilla",
	"EnviousExtract",
	"NegativeReflection"
]

var spritemap: Dictionary = {
	"DeathPotion": load("res://Assets/Art/DeathJuice.png"),
	"Vanilla": load("res://Assets/Art/Vanilla.png"),
	"EnviousExtract": load("res://Assets/Art/EnviousExtract.png"),
	"NegativeReflection": load("res://Assets/Art/NegativeReflection.png")
}

var dragging: bool = false
var starting_position: Vector2
var in_cauldron: bool

signal dropped_in_cauldron(ingredent_type)

# Called when the node enters the scene tree for the first time.
func _ready():

	# Setup Ingredient
	# Assign type if not manually assigned
	if type == "":
		type = ingredient_types[randi() % ingredient_types.size()]
	$Sprite2D.texture = spritemap[type]
	starting_position = position
	in_cauldron = false
	$Area2D.connect("area_entered", _on_cauldron_area_entered)
	$Area2D.connect("area_exited", _on_cauldron_area_exited)
	#print("I'm a ", type)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if dragging:
		# LERP = Smooth transition to mouse position. Kidna laggy and creates bugs
		# position = lerp(position, get_global_mouse_position(), 25 * delta)
		position = get_global_mouse_position()
		#print("Now im a ", type)


# Handle mouse event checks
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		# If left click AND mouse down, dragging enabled
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dragging = true
		# If left click AND mouse up, dragging disabled
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			dragging = false
			#print("We are in the bowl: ", in_cauldron)
			if in_cauldron == true:
				print("Dead: ", type)
				emit_signal("dropped_in_cauldron", type)
				queue_free()
			else:
				print("Back to shelf: ", type)
				position = starting_position
			
	# Touch screen support? Havnt tested this ever
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			position = event.get_position()


func _on_cauldron_area_entered(area):
	#print(area)
	if area.is_in_group("cauldron"):
		#print("IN CAULDRON (", type, "): ", in_cauldron)
		in_cauldron = true
		#print("AFTER ENTER (", type, "): ", in_cauldron)


func _on_cauldron_area_exited(area):
	#print(area)
	if area.is_in_group("cauldron"):
		#print("EXITED CAULDRON (", type, "): ", in_cauldron)
		in_cauldron = false
		#print("AFTER EXIT (", type, "): ", in_cauldron)
