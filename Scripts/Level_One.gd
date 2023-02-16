extends Node2D

onready var Globals = get_node("/root/Globals")
onready var tween : Tween = get_node("Ball/Ball_Camera/Tween")
onready var ballCamera = $Ball/Ball_Camera

func _process(_delta):
	
	if Globals.gameEnded:
		var _tween = tween.interpolate_property($Ball/Ball_Camera, "zoom",
		ballCamera.zoom, Vector2(1, 1), 0.1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		var _start = tween.start()
		
		$Level_Complete.visible = true
