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
var sprite: Sprite2D = $Sprite2D
@onready
var text: Label = get_node("ScrollDialouge/ScrollText")
var customer_type: String = "fishmaid"

var customerTypes: Array = ["fishmaid", "sad_ghost", "angry_cowboy", "electro_bard", "doggo", "evil_scientist", "frog_prince", "old_man", "sasquatch"]

var characterWalkingAnim: String = "Standard Customer Walk"
var characterLeavingAnim: String = "Standard Customer Leave"

var characterHeightOffset: Dictionary = {
	"angry_cowboy": 0,
	"electro_bard": 0,
	"doggo":  -725,
	"evil_scientist":  -300,
	"fishmaid":  0,
	"frog_prince":  -725,
	"old_man":  -250,
	"punny_skeleton": 0,
	"sad_ghost": 0,
	"sasquatch": 0,
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
	"fishmaid": "res://Assets/Art/Fishmaid(Talking).png",
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
	"frog_prince": "Greetings. I am a prince und'r a naughty enchantment. *Ribbit* A fav'r of magical nature, and thy kindness may setteth me free from this amphibious plight! *Ribbit*",
	"angry_cowboy": "Ah'm starvin'! Give me some guh-rub, now.",
	"electro_bard": "🎶 One drink, my friend, to set the vibe, a glass of lightning, let the music thrive! 🎶",
	"old_man": "Say, young'un, do you by any chance, got any o' them youth potions?",
	"punny_skeleton": "\"Bone\"-appetit, my good tavern owner! What's \"cooking\" on the menu tonight? Just don't leave me \"humerus,\" okay?",
	"doggo": "Bark Bark! Ruff Ruff!\nHowl… Bark!\nWoof woof?",
	"evil_scientist": "I seek a unique elixir, friend. A potion of uncommon properties, if you please. Kekeke…",
	"sasquatch": "… … Innkeeper … … normal?"
}

var talkingCharacterSprites: Dictionary = {
	"fishmaid": "res://Assets/Art/Fishmaid(Talking).png",
	"sad_ghost": "res://Assets/Art/Ghost(Talking).png",
	"angry_cowboy": "res://Assets/Art/Cowboy(Talking).png",
	"sasquatch": "res://Assets/Art/Cthulhu(Talking).png",
	"doggo": "res://Assets/Art/Doggo(Talking).png",
	"electro_bard": "res://Assets/Art/Electro_Bard(Talking).png",
	"evil_scientist": "res://Assets/Art/Evil_Scientist(Talking).png",
	"frog_prince": "res://Assets/Art/FrogPrince(Talking).png",
	"old_man": "res://Assets/Art/Old_Man(Talking).png"
}

var unsatisfiedCharacterSprites: Dictionary = {
	"fishmaid": "res://Assets/Art/Fishmaid(Upset).png",
	"sad_ghost": "res://Assets/Art/Ghost(Upset).png",
	"angry_cowboy": "res://Assets/Art/Cowboy(Upset).png",
	"sasquatch": "res://Assets/Art/Cthulhu(Upset).png",
	"doggo": "res://Assets/Art/Doggo(Upset).png",
	"electro_bard": "res://Assets/Art/Electro_Bard(Upset).png",
	"evil_scientist": "res://Assets/Art/Evil_Scientist(Upset).png",
	"frog_prince": "res://Assets/Art/FrogPrince(Upset).png",
	"old_man": "res://Assets/Art/Old_Man(Upset).png"
}

var desires: Dictionary = {
	"fishmaid": ["LovePotion", "AnimePotion"],
	"sad_ghost": ["ElixirOfLife"],
	"angry_cowboy": ["Steak", "Moonshine"],
	"sasquatch": ["AnimePotion"],
	"doggo": ["Bones", "Steak"],
	"electro_bard": ["Moonshine", "Omega3Supplement"],
	"evil_scientist": ["NuclearWaste", "DeathPotion"],
	"frog_prince": ["FruitCake", "LovePotion"],
	"old_man": ["YouthPotion", "ElixirOfLife"]
}

var results: Dictionary = {
	"fishmaid": -1,
	"sad_ghost":  -1,
	"angry_cowboy": -1,
	"sasquatch":  -1,
	"doggo": -1,
	"electro_bard": -1,
	"evil_scientist": -1,
	"frog_prince":  -1,
	"old_man":  -1,
}

# Called when the node enters the scene tree for the first time.
func _ready():
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
		results[customer_type] = randi_range(0,3)
	else:
		results[customer_type] = randi_range(4,5)
		
	# stop any sounds.
	$SoundStream.stop()
	# walk away
	walking.play(characterLeavingAnim)
	dialog.play("RESET")
	print("current results", results)
	
	

func updateSprite(path):
	sprite.texture = load(path)
	
func updateSpriteOffset():
	sprite.position.y = characterHeightOffset[customer_type] 
	
func spawnCustomer():
	if len(customerTypes) == 0:
		print("no customers remaining")
		return
		
	var possibleCustomer = customerTypes.pick_random()
	customerTypes.assign(customerTypes.filter(func(i): return i != possibleCustomer))
	
	print("A new customer was selected remaining options:", customerTypes)
	
	customer_type = possibleCustomer
	
	updateSprite(characterSprites[possibleCustomer])
	updateSpriteOffset()
	
	var phrase = characterDialog[possibleCustomer]
	text.text = str(phrase)
	
	walking.play(characterWalkingAnim)
	
