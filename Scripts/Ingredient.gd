extends Node2D

#################################
# RESPONSIBILITIES
#
# 1. Set sprite                     [ ]
# 2. Set sounds                     [ ]
# 3. Listen for mouse / drag events [ ]
# 4. Adjust position                [ ]
# 5. Signal entering collision      [ ]
# 
#################################

@export var type: String

var spritemap: Dictionary = {
	"DeathPotion": load("res://Assets/Art/DeathJuice.png"),
	"Vanilla": load("res://Assets/Art/Vanilla.png")
}

var dragging: bool = false
signal dragsignal;

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("I am a ", type)
	# Set sprite
	$Sprite2D.texture = spritemap[type]
	#print("I live at ", position)
	connect("dragsignal", _set_drag_pc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		position = lerp(position, get_global_mouse_position(), 25 * delta)

func _set_drag_pc():
	dragging=!dragging


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	#print(event)
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		print(event.pressed)
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("dragsignal")
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			emit_signal("dragsignal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()
