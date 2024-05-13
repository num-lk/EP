extends Node2D

@onready var AP = $AnimationPlayer;

# Called when the node enters the scene tree for the first time.
func _ready():
	AP.play("intro");
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
