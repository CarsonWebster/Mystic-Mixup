extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$BackgroundMusic.play(0.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "FadeIn":
		get_tree().change_scene_to_file("res://Scenes/Tavern.tscn")
