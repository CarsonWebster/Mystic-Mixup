extends Node2D

var ingredients = ["Green", "Red", "Blue", "Black"]

signal demand_ingredent()

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(571, 316), 1)
	
	emit_signal("demand_ingredent", ingredients[randi() % ingredients.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
