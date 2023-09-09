extends Node2D

###############################################################
# BASIC PROTOTYPE SCENE AND GAME CONTROLLER. 
# Responsibilities should be delegated to other scnenes later
###############################################################

# Export the customer scene as a PackedScene variable
@export var customer_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	# Spawn a new customer from the exported scene
	var customer_instance = customer_scene.instance()
	add_child(customer_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
