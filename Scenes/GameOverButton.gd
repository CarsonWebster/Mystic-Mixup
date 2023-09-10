extends Button

### Local Variables 
var mainMenuScene = "res://Scenes/Title.tscn"

func _on_button_up():
	get_tree().change_scene_to_file(mainMenuScene)
