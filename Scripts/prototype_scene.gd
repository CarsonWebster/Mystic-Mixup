extends Node2D

###############################################################
# BASIC PROTOTYPE SCENE AND GAME CONTROLLER. 
# Responsibilities should be delegated to other scnenes later
###############################################################

var demanded_color: String

# Export the customer scene as a PackedScene variable
#@export var customer_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	# Spawn a new customer from the exported scene
	#var customer = customer_scene.instantiate()
	#customer.position = Vector2(1093, 45)
	#add_child(customer)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_customer_demand_ingredent(color: String):
	$Label.text = color
	demanded_color = color
