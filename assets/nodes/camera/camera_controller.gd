extends Camera2D

# Export variables
@export var target: Node2D;
@export var track_speed: float = 10;
@export var offset_speed: float = 10;
@export var offset_scale: float = 0.1;

func _ready():
	pass # Replace with function body.

func _process(delta):
	
	# Account for delta time in camera tracking
	var blend = pow(0.5, delta * track_speed)
	
	# Lerp to target location
	position = target.position.lerp(position, blend);
	
	# Get current viewport
	var vp = get_viewport();
	
	# Calculate mouse distance from center
	var dist = vp.get_mouse_position() - Vector2(get_viewport_rect().size) / 2;
	
	# Scale distance
	dist = dist * offset_scale;
	
	# Account for delta time in mouse tracking
	blend = pow(0.5, delta * offset_speed)
	
	# Offset camerat toward mouse
	offset = dist.lerp(offset, blend);
