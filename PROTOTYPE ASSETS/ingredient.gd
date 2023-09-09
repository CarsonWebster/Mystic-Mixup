extends Node2D

@export var color: String
var dragging: bool = false

signal dragsignal;
# signal ingredent_clicked(color)

var color_dictionary = {
	"Green": Color("#00FF00"),  # Green color in hex format
	"Red": Color("#FF0000"),    # Red color in hex format
	"Blue": Color("#0000FF"),   # Blue color in hex format
	"Black": Color("#000000")   # Black color in hex format
}

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("dragsignal", _set_drag_pc)
	var tween = create_tween()
	tween.tween_property($ColorRect, "color", color_dictionary[color], 1)

func _on_color_rect_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		# Emit the signal when the ColorRect is clicked
		# emit_signal("color_rect_clicked", color)
		if color == $"..".demanded_color:
			get_tree().quit()
		emit_signal("dragsignal")
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT && !event.pressed:
		emit_signal("dragsignal")

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		position = lerp(position, get_global_mouse_position(), 25 * delta)


func _set_drag_pc():
	dragging=!dragging
	#print("Dragging: ", dragging)
