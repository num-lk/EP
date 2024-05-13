class_name NPC extends AnimatableBody2D

var last_position = Vector2.ZERO;
var direction = Vector2.ZERO;

@onready var sprite = $AnimatedSprite2D;
@onready var AT = $AnimationTree;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	AT.set("parameters/Walk/blend_position", direction);
	AT.set("parameters/conditions/moving", direction.length() > 0.0);
	AT.set("parameters/conditions/idle", direction.length() == 0.0);
	
func _physics_process(delta):
	# Record position before moving
	direction = (position - last_position).normalized();
	last_position = position;
