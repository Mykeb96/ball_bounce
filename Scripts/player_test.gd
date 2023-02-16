extends KinematicBody2D

var velocity : Vector2 = Vector2(0, 0)
const JUMP_SPEED : int = 1000
const MOVE_SPEED : int = 1000
const GRAVITY : int = 2900

func _physics_process(delta):
	# Apply gravity
	velocity.y += GRAVITY * delta
	look_at(get_global_mouse_position())
	process_input()
	
	velocity = move_and_slide(velocity, Vector2.UP)

func process_input():
	
	if Input.is_action_pressed("ui_up") && is_on_floor():
		velocity.y -= JUMP_SPEED
	
