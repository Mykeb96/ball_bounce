extends Control

onready var Globals = get_node("/root/Globals")
var gameTime : int

func _process(_delta):
	gameTime = Globals.gameTimeCompleted
	$Time_Text.text = "You beat the level in: " + str(gameTime / 60) + " minutes, and " + str(gameTime % 60) + " seconds!"


func _on_Quit_pressed():
	get_tree().quit()

func _on_Restart_pressed():
	Globals.gameEnded = false
	var _reload = get_tree().reload_current_scene()
