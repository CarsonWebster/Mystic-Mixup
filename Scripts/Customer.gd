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
	"fishmaid": "Standard Customer Leave",
	"sad_ghost": "Standard Customer Leave"
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
	"fishmaid": "res://Assets/Art/fishmaid.png",
	"sad_ghost": "res://Assets/Art/ghost.png",
}

var characterDialog: Dictionary = {
	"fishmaid": "Blub, blub, blubbbbb!\nBlub, blub, blub, blub.\nBlub, blub… …\nBlub, blub, blub?",
	"sad_ghost": "… *Whispers* …",
	"frog_prince": "Greetings, gentle tav'rn keepeth'r. *Ribbit* I am a prince und'r a naughty enchantment. *Ribbit* A fav'r of a magical nature, and thy kindness may setteth me free from this amphibious plight! *Ribbit*",
	"angry_cowboy": "Ah'm starvin'! Give me some guh-rub, now.",
	"electro_bard": "🎶 One drink, my friend, to set the vibe, a glass of lightning, let the music thrive! 🎶",
	"old_man": "Say, young'un, do you by any chance, got any o' them youth potions?",
	"punny_skeleton": "\"Bone\"-appetit, my good tavern owner! What's \"cooking\" on the menu tonight? Just don't leave me \"humerus,\" okay?",
	"doggo": "Bark Bark! Ruff Ruff!\nHowl… Bark!\nWoof woof?",
	"evil-scientist": "I seek a unique elixir, friend. A potion of uncommon properties, if you please. Kekeke…",
	"sasquatch": "… … Innkeeper … … normal?"
}

var talkingCharacterSprites: Dictionary = {
	"fishmaid": "res://Assets/Art/fishmaid.png",
	"sad_ghost": "res://Assets/Art/ghost_talking.png"
}

var unsatisfiedCharacterSprites: Dictionary = {
	"fishmaid": "res://Assets/Art/fishmaid_unsatisifed.png",
	"sad_ghost": "res://Assets/Art/ghost_unsatisfied.png",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	updateSprite(characterSprites[customer_type])
	
	var phrase = characterDialog[customer_type]
	text.text = str(phrase)
	
	var walkingAnimation = characterWalkingAnims[customer_type]
	walking.play(walkingAnimation)
	
	pass

func _on_animation_player_animation_started(anim_name):
	print("animation is starting: "+anim_name)

func _on_walking_animation_animation_finished(anim_name):
	if "Walk" in anim_name:
		customer_speak()
		

func _on_scroll_animation_animation_finished(anim_name):
	if anim_name == "Speech bubble movement": 
		customer_leave(false)
		
	print("scroll animation is done: "+anim_name) # Replace with function body.

func reset():
	pass

func customer_speak():
	# set talking sprite
	updateSprite(talkingCharacterSprites[customer_type])
	
	# start speech bubble
	dialog.play("Speech bubble movement")
	
	# update sound stream
	$SoundStream.stop()
	$SoundStream.stream = load(dialogSounds[customer_type])
	$SoundStream.play(0.0)

func customer_leave(isHappy): 
	if !isHappy: 
		updateSprite(unsatisfiedCharacterSprites[customer_type])
		
	$SoundStream.stop()
	var leavingAnimation = characterLeavingAnims[customer_type]
	walking.play(leavingAnimation)

func updateSprite(path):
	var sprite = load(path)
	node.set_texture(sprite)
