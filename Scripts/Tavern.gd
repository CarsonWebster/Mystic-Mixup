extends Node2D


#################################
# RESPONSIBILITIES
#
# 1. Manage ingredents    [ ]
# 2. Manage customers     [ ]
# 3. Manage score         [ ]
# 4. Manage timers        [ ]
# 5. Manage game over     [ ]
# 6. Manage craft button  [ ]
# 7. Manage UI menus      [ ]
# 
#################################

# Export the customer scene as a PackedScene variable
@export var customer_scene : PackedScene

@export var game_over_scene : PackedScene

signal GameActive(bool)

var product_types: Array = [
	"Moonshine",
	"DeathPotion",
	"LovePotion",
	"Bones",
	"MosaicFood",
	"ElixirOfLife",
	"AnimePotion",
	"Omega3Supplement",
	"Steak",
	"TamagoSushi",
	"NuclearWaste",
	"YouthPotion",
]

var product_sprite_map: Dictionary = {
	"Moonshine": load("res://Assets/Art/Moonshine.png"),
	"DeathPotion": load("res://Assets/Art/DeathJuice.png"),
	"LovePotion": load("res://Assets/Art/LovePotion.png"),
	"Bones": load("res://Assets/Art/Bones.png"),
	"MosaicFood": load("res://Assets/Art/MosaicFood.png"),
	"ElixirOfLife": load("res://Assets/Art/ElixirOfLife.png"),
	"AnimePotion": load("res://Assets/Art/AnimePotion.png"),
	"Omega3Supplement": load("res://Assets/Art/Omega3Supplement.png"),
	"Steak": load("res://Assets/Art/Steak.png"),
	"CrunchySalad": load("res://Assets/Art/CrunchySalad.png"),
	"TamagoSushi": load(""),
	"NuclearWaste": load("res://Assets/Art/Nuclear_Waste.png"),
	"YouthPotion": load(""),
	"FruitCake": load("res://Assets/Art/FruitCake.png"),
}

var combinations: Dictionary = {
	"FairyDust-NegativeReflection": "ElixirOfLife",
	"FairyDust-Vanilla": "ElixirOfLife",
	"FairyDust-MysteryBoxGood": "ElixirOfLife",
	"FairyDust-MysteryBoxGood-NegativeReflection": "ElixirOfLife",
	"FairyDust-MysteryBoxGood-NegativeReflection-Vanilla": "ElixirOfLife",
	"Bones": "Bones",
	"Bones-Hair": "DeathPotion",
	"Bones-Vanilla": "Bones",
	"Bones-MysteryMeat": "Steak",
	"Bones-CockatriceEgg": "Steak",
	"Bones-CockatriceEgg-Moonshine": "YouthPotion",
	"Bones-CockatriceEgg-Moonshine-Vanilla": "YouthPotion",
	"CockatriceEgg-GooseBerryBush-SpicySugar": "FruitCake",
	"CockatriceEgg-GooseBerryBush-SpicySugar-Vanilla": "FruitCake",
	"CockatriceEgg-MysteryMeat": "YouthPotion",
	"CockatriceEgg-SpicySugar": "FruitCake",
	"CockatriceEgg-SpicySugar-Vanilla": "FruitCake",
	"CockatriceEgg-SpicySugar-WargMilk": "FruitCake",
	"CockatriceEgg-SpicySugar-Vanilla-WargMilk": "FruitCake",
	"EnviousExtract-Vanilla": "LovePotion",
	"EnviousExtract-Rainbows": "LovePotion",
	"EnviousExtract-FairyDust": "LovePotion",
	"EnviousExtract-FairyDust-Rainbows": "LovePotion",
	"EnviousExtract-FairyDust-Rainbows-Vanilla": "LovePotion",
	"Hair-Vanilla": "LovePotion",
	"Hair-Rainbows": "DeathPotion",
	"FrogLegs-Hair": "NuclearWaste",
	"FrogLegs-Hair-WargMilk": "NuclearWaste",
	"FrogLegs-Hair-Vanilla-WargMilk": "NuclearWaste",
	"Moonshine": "Moonshine",
	"Moonshine-Vanilla": "Moonshine",
	"Moonshine-Rainbows": "AnimePotion",
	"Moonshine-MysteryMeat": "Steak",
	"Moonshine-MysteryMeat-SpicySugar": "Steak",
	"Moonshine-MysteryMeat-SpicySugar-Vanilla": "Steak",
	"AssortedRocks": "CrunchySalad",
	"AssortedRocks-Vanilla": "CrunchySalad",
	"AssortedRocks-Bones": "CrunchySalad",
	"AssortedRocks-Bones-Vanilla": "CrunchySalad",
	"MysteryMeat": "Steak",
	"MysteryMeat-Rainbows": "Bones",
	"MysteryMeat-Vanilla": "Omega3Supplement",
	"MysteryMeat-ToxicJellyfish": "Omega3Supplement",
	"MysteryMeat-ToxicJellyfish-WargMilk": "Omega3Supplement",
	"MysteryMeat-ToxicJellyfish-Vanilla-WargMilk": "Omega3Supplement",
	"CockatriceEgg-ToxicJellyfish": "Omega3Supplement",
	"CockatriceEgg": "TamagoSushi",
	"CockatriceEgg-Rainbows": "LovePotion",
	"CockatriceEgg-Vanilla": "TamagoSushi",
	"CockatriceEgg-GooseBerryBush": "TamagoSushi",
	"CockatriceEgg-LeprechaunBeard": "TamagoSushi",
	"CockatriceEgg-GooseBerryBush-LeprechaunBeard": "TamagoSushi",
	"CockatriceEgg-GooseBerryBush-LeprechaunBeard-Vanilla": "TamagoSushi",
	"ChemicalX": "DeathPotion",
	"ChemicalX-Hair": "AnimePotion",
	"ChemicalX-SpicySugar": "AnimePotion",
	"ChemicalX-ToxicJellyfish": "DeathPotion",
	"ChemicalX-ToxicJellyfish-Vanilla": "DeathPotion",
	"ChemicalX-ToxicJellyfish-Wolfsbane": "DeathPotion",
	"ChemicalX-ToxicJellyfish-Vanilla-Wolfsbane": "DeathPotion",
	"Rainbows-Vanilla": "AnimePotion",
	"FairyDust-Rainbows": "AnimePotion",
	"FairyDust-Moonshine": "AnimePotion",
	"FairyDust-Moonshine-Rainbows": "AnimePotion",
	"FairyDust-Moonshine-Rainbows-Vanilla": "AnimePotion"
}

var used_ingredents: Array

var product_result: String

var customer = null

var game_active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$BackgroundMusic.play(0.0)
	$Product/AnimationPlayer.play("RESET")
	$Product/AnimationPlayer.connect("animation_finished", _on_product_animation_finished)
	for node in $IngredentsGroup.get_children():
		if node.is_in_group("ingredient"):
			node.connect("dropped_in_cauldron", _on_ingredient_dropped_in_cauldron)
	
	# Play and wait for fade in
	$CanvasModulate/AnimationTree.play("FadeOut")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_ingredient_dropped_in_cauldron(ingredent_type):
	used_ingredents.append(ingredent_type)
	print("New Ingredent Added:")
	print(used_ingredents)


func _on_reset_button_pressed():
	if game_active:
		print("RESET")
		for node in $IngredentsGroup.get_children():
			if node.is_in_group("ingredient"):
				node.reset()
		used_ingredents = []

func determine_product():
	# Sort and filter out duplicates from the selection.
	var sorted = sorted_unique_array(used_ingredents)
	print("sorted array", sorted)
	# Join the key.
	var key = "-".join(sorted)
	# Find the item.
	print("found key", key)
	if key in combinations:
		return combinations[key]
	else:
		return "MosaicFood"


func _on_craft_button_pressed():
	
	if game_active:
		if len(used_ingredents) > 0:
			for node in $IngredentsGroup.get_children():
				if node.is_in_group("ingredient"):
					node.crafted()
			product_result = determine_product()

			# SET THE PRODUCT RESULT
			$Product.texture = product_sprite_map[product_result]
			$Product/AnimationPlayer.play("Present")
			game_active = false
			emit_signal("GameActive", false)
		
			used_ingredents = []

func _on_product_animation_finished(anim_name):
	if anim_name == "Present":
		# Your code to run after the "Present" animation is finished goes here.
		print("Animation 'Present' has finished.")
		print("We got a: ", product_result)
		
		# HERE IS WHERE THE CUSTOMER WILL CALL THE JUDGE FUNCTION
		customer.judge_product(product_result)
		$Product/AnimationPlayer.play("RESET")


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "FadeOut":
		
		# Spawn Customer
		customer = customer_scene.instantiate()
		customer.position = Vector2(1093, 45)
		add_child(customer)
		#emit_signal("GameActive", true)
		customer.connect("CustomerDoneWalking", _on_customer_done_walking)

func _on_customer_done_walking():
	game_active = true
	emit_signal("GameActive", true)


func _on_game_timer_game_over():
	game_active = false
	emit_signal("GameActive", false)
	var game_over_layer = game_over_scene.instantiate()
	game_over_layer.proto_results = customer.results
	add_child(game_over_layer)
	game_over_layer.z_index = 10


func sorted_unique_array(array: Array) -> Array:
	var unique: Array = []
	
	for item in array:
		if not unique.has(item):
			unique.append(item)
			
	unique.sort()
	
	return unique
