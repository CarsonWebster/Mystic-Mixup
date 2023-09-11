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
]
var product_sprite_map: Dictionary = {
	"Moonshine": load("res://Assets/Art/Moonshine.png"),
	"DeathPotion": load("res://Assets/Art/DeathJuice.png"),
	"LovePotion": load("res://Assets/Art/LovePotion.png"),
	"Bones": load("res://Assets/Art/Bones.png"),
	"MosaicFood": load("res://Assets/Art/MosaicFood.png"),
}

var used_ingredents: Array

var product_result: String

var customer = null

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
	print("RESET")
	for node in $IngredentsGroup.get_children():
		if node.is_in_group("ingredient"):
			node.reset()
	used_ingredents = []

func determine_product():
	return product_types.pick_random()

func _on_craft_button_pressed():

	for node in $IngredentsGroup.get_children():
		if node.is_in_group("ingredient"):
			node.crafted()
	used_ingredents = []

	# SET THE PRODUCT RESULT
	product_result = determine_product()
	$Product.texture = product_sprite_map[product_result]
	$Product/AnimationPlayer.play("Present")
	emit_signal("GameActive", false)

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
	emit_signal("GameActive", true)


func _on_game_timer_game_over():
	emit_signal("GameActive", false)
	var game_over_layer = game_over_scene.instantiate()
	game_over_layer.proto_results = customer.results
	add_child(game_over_layer)
	game_over_layer.z_index = 10
