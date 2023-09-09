extends Node2D

var ingredients = ["Green", "Red", "Blue", "Black"]

signal demand_ingredent(color: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(571, 316), 1)
	
	#emit_signal("demand_ingredent", ingredients[randi() % ingredients.size()])
	#tween.tween_callback(lambda: emit_signal("demand_ingredent", ingredients[randi() % ingredients.size()]))
	tween.tween_callback(_emit_demand_signal)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Callback function to emit the signal
func _emit_demand_signal():
	emit_signal("demand_ingredent", ingredients[randi() % ingredients.size()])
