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
	"Vanilla",
	"EnviousExtract",
	"NegativeReflection",
	"FrogLegs",
	"Bones",
	"Moonshine",
	"ToxicJellyfish",
	"Hair",
	"GameJam",
	"MysteryBox",
	"MysteryMeat",
	"SpicySugar",
	"GooseBerryBush",
	"CockatriceEgg",
	"Rainbows",
	"Wolfsbane"
]

var spritemap: Dictionary = {
	"Vanilla": load("res://Assets/Art/Vanilla.png"),
	"EnviousExtract": load("res://Assets/Art/EnviousExtract.png"),
	"NegativeReflection": load("res://Assets/Art/NegativeReflection.png"),
	"FrogLegs": load("res://Assets/Art/FrogLegs.png"),
	"Bones": load("res://Assets/Art/Bones.png"),
	"Moonshine": load("res://Assets/Art/Moonshine.png"),
	"ToxicJellyfish": load("res://Assets/Art/ToxicJellyfish.png"),
	"Hair": load("res://Assets/Art/Hair.png"),
	"GameJam": load("res://Assets/Art/GameJam.png"),
	"MysteryBox": load("res://Assets/Art/MysteryBox.png"),
	"MysteryMeat": load("res://Assets/Art/MysteryMeat.png"),
	"SpicySugar": load("res://Assets/Art/SpicySugar.png"),
	"GooseBerryBush": load("res://Assets/Art/GooseBerryBush.png"),
	"CockatriceEgg": load("res://Assets/Art/CockatriceEgg.png"),
	"Rainbows": load("res://Assets/Art/Rainbows.png"),
	"Wolfsbane": load("res://Assets/Art/Wolfsbane.png")
}

var spawning_chance: Dictionary = {
	"Vanilla": .1,
	"EnviousExtract": .2,
	"NegativeReflection": .1,
	"FrogLegs": .2,
	"Bones": .3,
	"Moonshine": .3,
	"ToxicJellyfish": .2,
	"Hair": .2,
	"GameJam": .1,
	"MysteryBox": .1,
	"MysteryMeat": .3,
	"SpicySugar": .2,
	"GooseBerryBush": .2,
	"CockatriceEgg": .3
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
		#type = ingredient_types[randi() % ingredient_types.size()]
		get_type()
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
				#print("Dead: ", type)
				emit_signal("dropped_in_cauldron", type)
				#queue_free()
				visible = false
			else:
				#print("Back to shelf: ", type)
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

func get_type():
	var type_index: int = 0
	var assigned = false
	var selected: String
	while !assigned:
		selected = ingredient_types[type_index]
		#print("Rolling for ", selected)
		var roll = randf()
		#print("Is ", roll, "Less than or equal to ", spawning_chance[selected])
		if spawning_chance[selected] >= roll:
			#print("Yep, got a ", selected)
			assigned = true
		else:
			type_index += 1
			if type_index >= len(ingredient_types):
				type_index = 0
	type = selected
	

func reset():
	position = starting_position
	visible = true

func crafted():
	#print(type, "Is In Cauldron: ", type)
	if in_cauldron:
	#if visible == false:
		#print(type, "Is becoming...")
		#type = ingredient_types[randi() % ingredient_types.size()]
		get_type()
		#print(type)
		$Sprite2D.texture = spritemap[type]
	position = starting_position
	visible = true
	
