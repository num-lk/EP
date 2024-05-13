extends CharacterBody2D

const SPEED = 80.0
const ACCEL = 1000.0
const JUMP_VELOCITY = -400.0

var last_position;

var npc_array = [];

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Get player sprite
@onready var sprite = $AnimatedSprite2D;

func _physics_process(delta):
	
	# Direction vector
	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	
	# Set velocity
	velocity = velocity.move_toward(dir.normalized() * SPEED, ACCEL * delta);
	
	# Record position before moving
	last_position = position;
	
	# Move character
	move_and_slide()
	
func _process(delta):
	# Interpolate sprite
	sprite.global_position = last_position.lerp(position, Engine.get_physics_interpolation_fraction());

# Handle unhandled player input
func _unhandled_input(event):
	# Interact with NPCs
	if (event.is_action("interact") && !npc_array.is_empty()):
		var closest_npc;
		var closest_distance = 256.0;
		# Get closest NPC from NPCs in range
		for npc in npc_array:
			var distance = npc.position.distance_to(position);
			if(closest_distance > distance):
				closest_distance = distance;
				closest_npc = npc as NPC;
		#closest_npc.interact();

func _on_inertact_area_body_entered(body: PhysicsBody2D):
	var npc := body as NPC;
	# Register NPC as in range
	if not npc:
		return;
	npc_array.append(npc);

func _on_inertact_area_body_exited(body: PhysicsBody2D):
	var npc := body as NPC;
	# Register NPC as out of range
	if not npc:
		return;
	npc_array.erase(npc);
