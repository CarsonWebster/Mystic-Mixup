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

var used_ingredents: Array


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$BackgroundMusic.play(0.0)
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


func _on_craft_button_pressed():
	print("CRAFT")
	print("You Get A Score Of...")
	print(randi_range(1, 10))
