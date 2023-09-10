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
#@export var ingredient_scene : PackedScene

# DEPRECATED but here just in case
#var ingredient_positions : Array = [
#	Vector2(150, 325),
#	Vector2(336, 325),
#	Vector2(336, 579),
#	Vector2(149, 579),
#	Vector2(149, 799),
#	Vector2(339, 799),
#	Vector2(360, 1040),
#	Vector2(148, 1040),
#	Vector2(1533, 327),
#	Vector2(1726, 329),
#	Vector2(1726, 584),
#	Vector2(1529, 584),
#	Vector2(1529, 809),
#	Vector2(1733, 809),
#	Vector2(1733, 1053),
#	Vector2(1524, 1052)
#]

var ingredient_types: Array = [
	"DeathPotion",
	"Vanilla",
	"EnviousExtract",
	"NegativeReflection"
]

var product_types: Array = [
	"Moonshine",
]
var product_sprite_map: Dictionary = {
	"Moonshine": load("res://Assets/Art/Moonshine.png")
}

var used_ingredents: Array

var product_result: String


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$BackgroundMusic.play(0.0)
	$Product/AnimationPlayer.play("RESET")
	$Product/AnimationPlayer.connect("animation_finished", _on_product_animation_finished)
	# Spawn Itmes DEPRECATED FROM TAVERN RESPONSABILITY
#	for i in range(len(ingredient_positions)):
#		var ingredient_instance = ingredient_scene.instantiate()
#		ingredient_instance.position = ingredient_positions[i]
#		ingredient_instance.type = ingredient_types[randi() % ingredient_types.size()]
#		add_child(ingredient_instance)

	for node in $IngredentsGroup.get_children():
		if node.is_in_group("ingredient"):
			node.connect("dropped_in_cauldron", _on_ingredient_dropped_in_cauldron)


	# Spawn Customer
	var customer = customer_scene.instantiate()
	customer.position = Vector2(1093, 45)
	add_child(customer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(get_global_mouse_position())
	pass


func _on_ingredient_dropped_in_cauldron(ingredent_type):
	used_ingredents.append(ingredent_type)
	print("New Ingredent Added:")
	print(used_ingredents)


func _on_reset_button_pressed():
	print("RESET")
	for node in $IngredentsGroup.get_children():
		if node.is_in_group("ingredient"):
			node.reset()
	used_ingredents = []

func determine_product():
	return product_types.pick_random()

func _on_craft_button_pressed():

	#print("CRAFT")
	#print("You Get A Score Of...")
	#print(randi_range(1, 10))

	for node in $IngredentsGroup.get_children():
		if node.is_in_group("ingredient"):
			node.crafted()
	used_ingredents = []

	# SET THE PRODUCT RESULT
	product_result = determine_product()
	$Product.texture = product_sprite_map[product_result]
	$Product/AnimationPlayer.play("Present")

func _on_product_animation_finished(anim_name):
	if anim_name == "Present":
		# Your code to run after the "Present" animation is finished goes here.
		print("Animation 'Present' has finished.")
		print("We got a: ", product_result)
		
		# HERE IS WHERE THE CUSTOMER WILL CALL THE JUDGE FUNCTION
		#customer.judge_product(product_result)

