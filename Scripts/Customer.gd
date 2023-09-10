extends Node

#################################
# RESPONSIBILITIES
#
# 1. Set sprite                    [ ]
# 2. Set sounds                    [ ]
# 3. Listen for product signals    [ ]
# 4. Act accordingly               [ ]
# 5. Signal action to game manager [ ]
# 
#################################

### Local References ###
@onready
var walking: AnimationPlayer = $WalkingAnimation
@onready
var dialog: AnimationPlayer = get_node("ScrollDialouge/ScrollAnimation")
@onready
var sounds: AudioStreamPlayer2D = $SoundStream
@onready
var node: Node2D = $"."
@onready
var text: Label = get_node("ScrollDialouge/ScrollText")

var customer_type: String = "fishmaid"

var characterWalkingAnims: Dictionary = {
	"fishmaid": "Standard Customer Walk",
	"sad_ghost": "Standard Customer Walk"
}

var characterLeavingAnims: Dictionary = {
	"fishmaid": "Standard Customer Leave"
}

var dialogSounds: Dictionary = {
	"angry_cowboy": "res://Assets/Miguels Workspace/SoundEffects/Characters/angry-cowboy.wav",
	"electro_bard": "res://Assets/Miguels Workspace/SoundEffects/Characters/electro-bard.wav",
	"doggo": "res://Assets/Miguels Workspace/SoundEffects/Characters/dog-boi.wav",
	"evil_scientist": "res://Assets/Miguels Workspace/SoundEffects/Characters/evil-scientist.wav",
	"fishmaid": "res://Assets/Miguels Workspace/SoundEffects/Characters/fishmaid.wav",
	"frog_prince": "res://Assets/Miguels Workspace/SoundEffects/Characters/frog-prince.wav",
	"old_man": "res://Assets/Miguels Workspace/SoundEffects/Characters/oldman.wav",
	"punny_skeleton": "res://Assets/Miguels Workspace/SoundEffects/Characters/punny-skeleton.wav",
	"sad_ghost": "res://Assets/Miguels Workspace/SoundEffects/Characters/sad-ghost.wav",
	"sasquatch": "res://Assets/Miguels Workspace/SoundEffects/Characters/sasquatch.wav",
}

var characterSprites: Dictionary = {
	"sad_ghost": "res://Assets/Art/ghost.png",
	"fishmaid": "res://Assets/Art/FishCustomer.png"
}

var characterDialog: Dictionary = {
	"fishmaid": "Blub, blub, blubbbbb!\nBlub, blub, blub, blub.\nBlub, blub… …\nBlub, blub, blub?",
	"sad_ghost": "Something else",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite = load(characterSprites[customer_type])
	node.set_texture(sprite)
	
	var phrase = characterDialog[customer_type]
	text.text = str(phrase)
	
	var walkingAnimation = characterWalkingAnims[customer_type]
	
	walking.play(walkingAnimation)
	pass

func _on_animation_player_animation_finished(anim_name):
	print("animation is done: "+anim_name)

func _on_animation_player_animation_started(anim_name):
	print("animation is starting: "+anim_name)

func _on_walking_animation_animation_finished(anim_name):
	dialog.play("Speech bubble movement")
	$SoundStream.stop()
	$SoundStream.stream = load(dialogSounds[customer_type])
	$SoundStream.play(0.0)

func _on_scroll_animation_animation_finished(anim_name):
	if anim_name == "Speech bubble movement": 
		var leavingAnimation = characterLeavingAnims[customer_type]
		walking.play(leavingAnimation)
		
	print("scroll animation is done: "+anim_name) # Replace with function body.

func reset():
	pass
