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

var customer_type: String = "fishmaid"

var dialogSounds: Dictionary = {
	"angry_cowboy": "res://Assets/Miguels Workspace/SoundEffects/Characters/angry-cowboy.wav",
	"bicycle_man": "res://Assets/Miguels Workspace/SoundEffects/Characters/bike-boi.wav",
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

var customermap : Dictionary = {
	"fishmaid" : load("res://Assets/Art/FishCustomer.png"),
	"frog_prince" : load("res://Assets/Art/FrogPrince(Talking).png"),
	"angry_cowboy" : load("res://Assets/Art/Cowboy(talking).png")
}
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Customer walk")
	#$AnimationPlayer.animation_finished


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	#print(anim_name)
	if anim_name == "Customer walk":
		$ScrollDialouge/ScrollText.text = "I WANNA ROCK ROCK!!! DUN DUN DUN DUN DUN DUN DUN I WANT TO ROCK ROCK"
		$AnimationPlayer.play("Dialog")
		play_dialog_sound(customer_type)
		
		
func play_dialog_sound(customer_type):
	$SoundStream.stop()
	$SoundStream.stream = load(dialogSounds[customer_type])
	$SoundStream.play(0.0)
