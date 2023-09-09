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

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("customerWalk")
	#$AnimationPlayer.animation_finished


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	#print(anim_name)
	if anim_name == "customerWalk":
		$ScrollDialouge/ScrollText.text = "I WANNA ROCK ROCK!!! DUN DUN DUN DUN DUN DUN DUN I WANT TO ROCK ROCK"
		$AnimationPlayer.play("Dialog")
