extends Node

### Local References to external nodes. ###
@onready
var primaryTimer: Timer = $PrimaryTimer
@onready
var secondaryTimer: Timer  = $SecondaryTimer
@onready
var duration: Label = get_node("VBoxContainer/Duration")
@onready
var backgroundMusic: AudioStreamPlayer2D = get_node("../BackgroundMusic")
@onready
var timerEndingMusic: AudioStreamPlayer2D = get_node("../TimerEndingMusic")
@onready
var timerWarningEffect: AudioStreamPlayer2D = get_node("../TimerWarningEffect")

### Local Variables ###
var isOneShotTimer = true
var isOnSecondaryTimer = false
var primaryDuration = 60
var secondaryDuration = 30
var redColor = Color(1,0,0,1)
var fontColorKey = "font_color"
var defaultSoundStartPoint = 0.0
var countdownDecimalPadding = 2
#var gameOverScene = "res://Scenes/Prototyping.tscn"
var gameOverScene = "res://Scenes/game_over.tscn"

signal GameOver

var gameStarted: bool = false

func _ready():
	# setup secondary timer, but wait.
	secondaryTimer.set_wait_time(secondaryDuration)
	secondaryTimer.one_shot = isOneShotTimer
	
	# setup & start primary timer
	primaryTimer.set_wait_time(primaryDuration)
	primaryTimer.one_shot = isOneShotTimer
	#primaryTimer.start(defaultSoundStartPoint)

func _process(_delta):
	# secondary time won't get added unless it starts.
	# because of that, we must manually add the time offset 
	# that the secondary timer would normally apply.
	var currentCountdownTime = primaryTimer.time_left + secondaryTimer.time_left
	if !isOnSecondaryTimer:
		currentCountdownTime += secondaryDuration
	
	# assign the duration text	
	if gameStarted:
		duration.text = str(currentCountdownTime).pad_decimals(countdownDecimalPadding)
	else:
		duration.text = ""

# After the first timer ends, stop the background music, play the warning sound.
func _on_primary_timer_timeout():
	isOnSecondaryTimer = true;
	# make font red
	duration.add_theme_color_override(fontColorKey, redColor)
	# update music
	backgroundMusic.stop()
	timerWarningEffect.play(defaultSoundStartPoint)
	timerEndingMusic.play(defaultSoundStartPoint)
	# start secondary timer
	secondaryTimer.start()
	
func _on_timer_warning_effect_finished():
	# TODO: might not be necessary afterall.
	pass

func _on_secondary_timer_timeout():
	#get_tree().change_scene_to_file(gameOverScene)
	emit_signal("GameOver")
	


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "FadeOut":
		gameStarted = true
		primaryTimer.start(defaultSoundStartPoint)
