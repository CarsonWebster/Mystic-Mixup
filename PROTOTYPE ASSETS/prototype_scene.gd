extends Node2D

###############################################################
# BASIC PROTOTYPE SCENE AND GAME CONTROLLER. 
# Responsibilities should be delegated to other scnenes later
###############################################################

var demanded_color: String

# Export the customer scene as a PackedScene variable
@export var customer_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	# Spawn a new customer from the exported scene
	var customer = customer_scene.instantiate()
	customer.position = Vector2(1093, 45)
	add_child(customer)
	customer.demand_ingredent.connect(_on_customer_demand_ingredent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_customer_demand_ingredent(color: String):
	#print("Got customer signal")
	$DialogBox.visible_ratio = 0
	$DialogBox.text = "I AM HUNGRY FOR SOME " + color + "!"
	demanded_color = color
	var tween = create_tween()
	tween.tween_property($DialogBox, "visible_ratio", 1, 1)
