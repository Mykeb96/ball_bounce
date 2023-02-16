extends Node

var gameEnded : bool = false
var gameReported : bool = false
var gameTime : int
var gameTimeCompleted : int

func _process(_delta):
	
	gameTime = Time.get_ticks_msec() / 1000
	
	if gameEnded && gameReported == false:
		gameTimeCompleted = gameTime
		gameReported = true
