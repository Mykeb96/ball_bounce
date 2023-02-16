extends RigidBody2D

onready var Globals = get_node("/root/Globals")

func _physics_process(_delta):

	if get_colliding_bodies().size() > 0:
		Globals.gameEnded = true
		apply_torque_impulse(-350000)
