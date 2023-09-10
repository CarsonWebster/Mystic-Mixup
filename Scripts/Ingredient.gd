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

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("I am a ", type)
	# Set sprite
	$Sprite2D.texture = spritemap[type]
	#print("I live at ", position)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
