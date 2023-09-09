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

# Called when the node enters the scene tree for the first time.
func _ready():
	# Spawn Customer
	var customer = customer_scene.instantiate()
	customer.position = Vector2(1093, 45)
	add_child(customer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
