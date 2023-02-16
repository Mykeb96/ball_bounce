extends KinematicBody2D

const WALK_FORCE = 1800
const WALK_MAX_SPEED = 1800
const STOP_FORCE = 4500
const JUMP_SPEED = 1800
const JUMP_MAX_SPEED = 2600

var canDoubleJump = true
var canDash = true
var canTouchWall = true

var velocity = Vector2()

var gravity = 3200

func _physics_process(delta):
	# Horizontal movement code. First, get the player's input.
	var walk = WALK_FORCE * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	# Slow down the player if they're not trying to move.
	if abs(walk) < WALK_FORCE * 0.2:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += walk * (delta * 10)
	# Clamp to the maximum horizontal movement speed.
	if is_on_floor():
		velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
	else:
		velocity.x = clamp(velocity.x, -JUMP_MAX_SPEED, JUMP_MAX_SPEED)

	if is_on_floor():
		canDoubleJump = true
		canDash = true
	if is_on_wall():
		if canTouchWall:
			canDash = true
			canDoubleJump = true
			print("on wall")
	
	if Input.is_action_pressed("ui_left") == false and Input.is_action_pressed("ui_right") == false:
		canTouchWall = false
	else:
		canTouchWall = true

	if Input.is_action_just_pressed("ui_shift") and is_on_floor() == false and canDash:
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 8000
			canDash = false
		elif Input.is_action_pressed("ui_right"):
			velocity.x += 8000
			canDash = false

	# Vertical movement code. Apply gravity.
	velocity.y += gravity * (delta * 2)

	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide(velocity, Vector2.UP)

	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = -JUMP_SPEED
	
	# check for jumping and fast falls if down is pressed
	if is_on_floor() == false && Input.is_action_just_pressed("ui_down"):
		velocity.y += gravity * (delta * 60)
	
	# Double Jump
	if is_on_floor() == false and Input.is_action_just_pressed("ui_up") and canDoubleJump:
		velocity.y = -JUMP_SPEED - 800
		if is_on_wall() == false:
			canDoubleJump = false
	
	#if grabbing a wall, slow down the fall
	if is_on_wall():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			velocity.y = 100

	if is_on_floor() == false and is_on_wall() and canTouchWall:
		if Input.is_action_just_pressed("ui_up") and Input.is_action_pressed("ui_left"):
			velocity.y = -JUMP_SPEED - 800
			velocity.x += 14000
		elif Input.is_action_just_pressed("ui_up") and Input.is_action_pressed("ui_right"):
			velocity.y = -JUMP_SPEED - 800
			velocity.x -= 14000
