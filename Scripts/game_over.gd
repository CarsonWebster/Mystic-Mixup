extends Node2D


#var proto_results: Dictionary = {
#	"fishmaid": 0,
#	"sad_ghost":  0,
#	"angry_cowboy": 0,
#	"sasquatch":  0,
#	"doggo": 0,
#	"electro_bard": 0,
#	"evil_scientist": 0,
#	"frog_prince":  0,
#	"old_man": 0,
#}
@export var proto_results: Dictionary

var satisfied_text: Dictionary = {
	"fishmaid": "Blub blub blub blub!",
	"sad_ghost":  "Whispers Whispers. Whispers",
	"angry_cowboy": "Ain't bad, ah reckon.",
	"sasquatch":  "Um, … thank you for making me human. I appreciate it.",
	"doggo": "Bark Bark!",
	"electro_bard": "🎶One drink in hand, life's grand, let's play and sway, through the night and day!🎶",
	"evil_scientist": "Thank you, tavern keeper. This potion shall serve me well … … … In ways you can't even imagine.",
	"frog_prince":  "A potion of exceptional quality, fitting f'r a prince liketh myself. Ribbit",
	"old_man": "Well now, ain't you a real gem? Much obliged, my boy. A swig of that potion, just perfect.",
}

var terrible_text: Dictionary = {
	"fishmaid": "…",
	"sad_ghost":  "… … … whisper",
	"angry_cowboy": "* Glares at you menacingly *",
	"sasquatch":  "… Bad.",
	"doggo": "Grrr! Grrr! Bark!",
	"electro_bard": "This... I can't even… what",
	"evil_scientist": "This is worthless! I wanted something else entirely, you fool!",
	"frog_prince":  "This foul concoction is an affront to royal tastes, tav'rn keepeth'r! Ribbit",
	"old_man": "I'll let it slide this time, but don't think you can fool an old-timer like me again.",
}

var average_text: Dictionary = {
	"fishmaid": "blub…",
	"sad_ghost":  "…",
	"angry_cowboy": "It’s meh…",
	"sasquatch":  "…",
	"doggo": "Bark.",
	"electro_bard": "🎶Meh… 🎶",
	"evil_scientist": "It’s meh…",
	"frog_prince":  "It’s meh…",
	"old_man": "It’s meh…",
}

var dead_text: Dictionary = {
	"fishmaid": "blubblubblub…",
	"sad_ghost":  "You killed yourself.",
	"angry_cowboy": "I died.",
	"sasquatch":  "Dead.",
	"doggo": "* Whimper *",
	"electro_bard": "I died.",
	"evil_scientist": "I died.",
	"frog_prince":  "I died.",
	"old_man": "I died.",
}


func get_stars(rating):
	if rating <= 0:
		return "Zero Stars"
	elif rating == 1:
		return "One Star"
	elif rating == 2:
		return "Two Stars"
	elif rating == 3:
		return "Three Stars"
	elif rating == 4:
		return "Four Stars"
	else:
		return "Five Stars"

func get_review_pool(numStars: int):
	if numStars == 0:
		return dead_text
	elif numStars == 1:
		return terrible_text
	elif numStars > 4:
		return satisfied_text
	else:
		return average_text

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(proto_results)
	for character in proto_results:
		if proto_results[character] > -1:
			if character == "fishmaid":
				$FishmaidPortrait.visible = true
				$FishMaidStars.play(get_stars(proto_results[character]))
				$FishMaidStars.visible = true
				$FishMaidLabel.text = get_review_pool(proto_results[character])[character]
				$FishMaidLabel.visible = true
			elif character == "sad_ghost":
				$GhostPortrait.visible = true
				$GhostStars.play(get_stars(proto_results[character]))
				$GhostStars.visible = true
				$GhostLabel.text = get_review_pool(proto_results[character])[character]
				$GhostLabel.visible = true
			elif character == "angry_cowboy":
				$AngryCowboyPortrait.visible = true
				$AngryCowboyStars.play(get_stars(proto_results[character]))
				$AngryCowboyStars.visible = true
				$AngryCowboyLabel.text = get_review_pool(proto_results[character])[character]
				$AngryCowboyLabel.visible = true
			elif character == "doggo":
				$DogPortrait.visible = true
				$DogStars.play(get_stars(proto_results[character]))
				$DogStars.visible = true
				$DogLabel.text = get_review_pool(proto_results[character])[character]
				$DogLabel.visible = true
			elif character == "electro_bard":
				$ElectroBardPortrait.visible = true
				$ElectroBardStars.play(get_stars(proto_results[character]))
				$ElectroBardStars.visible = true
				$ElectroBardLabel.text = get_review_pool(proto_results[character])[character]
				$ElectroBardLabel.visible = true
			elif character == "old_man":
				$OldManPortrait.visible = true
				$OldManStars.play(get_stars(proto_results[character]))
				$OldManStars.visible = true
				$OldManLabel.text = get_review_pool(proto_results[character])[character]
				$OldManLabel.visible = true
			elif character == "frog_prince":
				$FrogPrincePortrait.visible = true
				$FrogPrinceStars.play(get_stars(proto_results[character]))
				$FrogPrinceStars.visible = true
				$FrogPrinceLabel.text = get_review_pool(proto_results[character])[character]
				$FrogPrinceLabel.visible = true
			elif character == "sasquatch":
				$CthulhuPortrait.visible = true
				$CthulhuStars.play(get_stars(proto_results[character]))
				$CthulhuStars.visible = true
				$CthulhuLabel.text = get_review_pool(proto_results[character])[character]
				$CthulhuLabel.visible = true
			elif character == "evil_scientist":
				$EvilScientistPortrait.visible = true
				$EvilScientistStars.play(get_stars(proto_results[character]))
				$EvilScientistStars.visible = true
				$EvilScientistLabel.text = get_review_pool(proto_results[character])[character]
				$EvilScientistLabel.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

