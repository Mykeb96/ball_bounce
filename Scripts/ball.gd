extends RigidBody2D

var canInteract : bool = true
var deadTexture = preload("res://Textures/Sprites/Player/player_ball_dead_new.png")
var aliveTexture = preload("res://Textures/Sprites/Player/player_ball.png")
onready var Globals = get_node("/root/Globals")

func _physics_process(_delta):
	
	$Position2D.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("left_click") && canInteract:
		apply_central_impulse((get_global_mouse_position() - global_position) * 1.5)
		canInteract = false
		
	if get_colliding_bodies().size() > 0:
		canInteract = true
	
	if canInteract:
		$Position2D/Power_Line.points = PoolVector2Array([Vector2(0,0), Vector2((get_global_mouse_position() - position).length(), 0)])
		$Ball_Sprite.texture = aliveTexture
	else:
		$Position2D/Power_Line.points = PoolVector2Array([Vector2(0,0), Vector2(0, 0)])
		if !Globals.gameEnded:
			$Ball_Sprite.texture = deadTexture
		
	if Globals.gameEnded:
		$Position2D/Power_Line.points = PoolVector2Array([Vector2(0,0), Vector2(0, 0)])
		mode = RigidBody2D.MODE_STATIC
