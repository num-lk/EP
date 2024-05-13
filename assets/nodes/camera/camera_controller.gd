extends Camera2D

# Export variables
@export var target: Node2D;
@export var track_speed: float = 10;
@export var seek_speed: float = 10;
@export var seek_scale: float = 0.1;
@export var float_speed: float = 1;
@export var float_scale: Vector2 = Vector2.ONE;

var seek_offset = Vector2.ZERO;
var float_offset = Vector2.ZERO;

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
	dist = dist * seek_scale;
	
	# Account for delta time in mouse tracking
	blend = pow(0.5, delta * seek_speed)
	
	# Offset camera toward mouse
	seek_offset = dist.lerp(seek_offset, blend);
	
	# Float camera around
	var time = Time.get_ticks_msec() / 1000.0 * float_speed;
	var float_offset = Vector2(sin(time) * float_scale.x, cos(time * 0.5) * float_scale.y);
	
	# Offset camera
	offset = seek_offset + float_offset;
