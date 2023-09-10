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

signal CustomerDoneWalking

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

#var customerTypes: Array = ["fishmaid", "sad_ghost", "angry_cowboy", "electro_bard", "doggo", "evil_scientist", "frog_prince", "old_man", "sasquatch"]
var customerTypes: Array = ["fishmaid", "sad_ghost"]
var characterWalkingAnims: Dictionary = {
	"fishmaid": "Standard Customer Walk",
	"sad_ghost": "Standard Customer Walk",
	"angry_cowboy": "Standard Customer Walk",
	"electro_bard": "Standard Customer Walk",
	"doggo": "Standard Customer Walk",
	"evil_scientist": "Standard Customer Walk",
	"frog_prince": "Standard Customer Walk",
	"old_man": "Standard Customer Walk",
	"punny_skeleton": "Standard Customer Walk",
	"sasquatch": "Standard Customer Walk",
}

var characterLeavingAnims: Dictionary = {
	"fishmaid": "Standard Customer Leave",
	"sad_ghost": "Standard Customer Leave",
	"angry_cowboy": "Standard Customer Leave",
	"electro_bard": "Standard Customer Leave",
	"doggo": "Standard Customer Leave",
	"evil_scientist": "Standard Customer Leave",
	"frog_prince": "Standard Customer Leave",
	"old_man": "Standard Customer Leave",
	"punny_skeleton": "Standard Customer Leave",
	"sasquatch": "Standard Customer Leave",
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
	"sad_ghost": "res://Assets/Art/Ghost(Idle).png",
	"angry_cowboy": "res://Assets/Art/Cowboy(Idle).png",
	"sasquatch": "res://Assets/Art/Cthulhu(Idle).png",
	"doggo": "res://Assets/Art/Doggo(Idle).png",
	"electro_bard": "res://Assets/Art/Electro_Bard(Idle).png",
	"evil_scientist": "res://Assets/Art/Evil_Scientist(Idle).png",
	"frog_prince": "res://Assets/Art/FrogPrince(Idle).png",
	"old_man": "res://Assets/Art/Old_Man(Idle).png"
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
	"evil_scientist": "I seek a unique elixir, friend. A potion of uncommon properties, if you please. Kekeke…",
	"sasquatch": "… … Innkeeper … … normal?"
}

var talkingCharacterSprites: Dictionary = {
	"fishmaid": "res://Assets/Art/fishmaid.png",
	"sad_ghost": "res://Assets/Art/ghost_talking.png",
	"angry_cowboy": "res://Assets/Art/Cowboy(talking).png",
	"sasquatch": "res://Assets/Art/Cthulhu(Talking).png",
	"doggo": "res://Assets/Art/Doggo(Talking).png",
	"electro_bard": "res://Assets/Art/Electro_Bard(Talking).png",
	"evil_scientist": "res://Assets/Art/Evil_Scientist(Talking).png",
	"frog_prince": "res://Assets/Art/FrogPrince(Talking).png",
	"old_man": "res://Assets/Art/Old_Man(Talking).png"
}

var unsatisfiedCharacterSprites: Dictionary = {
	"fishmaid": "res://Assets/Art/fishmaid_unsatisifed.png",
	"sad_ghost": "res://Assets/Art/ghost_unsatisfied.png",
	"angry_cowboy": "res://Assets/Art/Cowboy(upset).png",
	"sasquatch": "res://Assets/Art/Cthulhu(Upset).png",
	"doggo": "res://Assets/Art/Doggo(Upset).png",
	"electro_bard": "res://Assets/Art/Electro_Bard(Upset).png",
	"evil_scientist": "res://Assets/Art/Evil_Scientist(Upset).png",
	"frog_prince": "res://Assets/Art/FrogPrince(Upset).png",
	"old_man": "res://Assets/Art/Old_Man(Upset).png"
}

var desires: Dictionary = {
	"fishmaid": ["LovePotion"],
	"sad_ghost": ["ElixerOfLife"],
	"angry_cowboy": ["Steak"],
	"sasquatch": ["AnimePotion"],
	"doggo": ["Bones"],
	"electro_bard": ["Moonshine"],
	"evil_scientist": ["NuclearWaste"],
	"frog_prince": ["FruitCake"],
	"old_man": ["YouthPotion"]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO: randomize
	spawnCustomer()
	

func _on_animation_player_animation_started(anim_name):
	print("animation is starting: "+anim_name)

func _on_walking_animation_animation_finished(anim_name):
	if "Walk" in anim_name:
		customer_speak()
		emit_signal("CustomerDoneWalking")
	if "Leave" in anim_name:
		spawnCustomer()
		

func _on_scroll_animation_animation_finished(anim_name):
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

func judge_product(productName): 
	var happyProducts = desires[customer_type]
	
	# customer is satisfied
	if productName not in happyProducts: 
		updateSprite(unsatisfiedCharacterSprites[customer_type])
		
	# stop any sounds.
	$SoundStream.stop()
	# walk away
	var leavingAnimation = characterLeavingAnims[customer_type]
	walking.play(leavingAnimation)
	dialog.play("RESET")
	

func updateSprite(path):
	var sprite = load(path)
	node.set_texture(sprite)
	
func spawnCustomer():
#	var possibleCustomer = customerTypes.pick_random()
	var possibleCustomer = "sad_ghost"
	print("A new customer was selected", possibleCustomer)
	
	customer_type = possibleCustomer
	
	updateSprite(characterSprites[possibleCustomer])
	
	var phrase = characterDialog[possibleCustomer]
	text.text = str(phrase)
	
	var walkingAnimation = characterWalkingAnims[possibleCustomer]
	walking.play(walkingAnimation)
	
