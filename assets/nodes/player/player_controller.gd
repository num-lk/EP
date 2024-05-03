extends CharacterBody2D


const SPEED = 600.0
const ACCEL = 2400.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	# Get input
	var move_left = Input.get_action_strength("move_left");
	var move_right = Input.get_action_strength("move_right");
	var move_up = Input.get_action_strength("move_up");
	var move_down = Input.get_action_strength("move_down");
	
	# Direction vector
	var dir = Vector2(move_right - move_left, move_down - move_up);
	
	# Set velocity
	velocity = velocity.move_toward(dir.normalized() * SPEED, ACCEL * delta);
	
	# Move character
	move_and_slide()
