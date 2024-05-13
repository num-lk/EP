class_name SpeechBox extends Control

@onready var AP = $AnimationPlayer;
@onready var speaker_label = $Speaker;
@onready var text_label = $Text;

var text_visible = 0.0;

const TEXT_SPEED = 25.0;

var dialogue;

var intro_cutscene_dialogue = [
	{
		"speaker": "Partijas vadītājs",
		"text": "Tādēļ, tas ir svarīgi, ka ikviens balstiesīgais piedalās \n vēlēšanās!",
		"next": 1,
		"skippable": false
	},
	{
		"speaker": "Draugs",
		"text": "Dzirdēji? Tas ir nopietni!",
		"next": 2,
		"skippable": false
	},
	{
		"choices": [
			"Nezinu, neesmu īsti pārliecināts.",
			"Pilnībā tev piekrītu, tas ir obligāti jādara!"
		]
	}
];

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var chars = text_label.text.length();
	if(text_visible < chars):
		text_visible = min(chars, text_visible + TEXT_SPEED * delta);
		text_label.visible_characters = text_visible;

func skip():
	text_visible = text_label.text.length();
	text_label.visible_characters = text_visible;

# Handle GUI input
func _gui_input(event):
	# Check if dialogue is skippable
	if event.is_action_pressed("interact") && dialogue["skippable"]:
		# Skip dialogue
		proceed();

func proceed():
	var chars = text_label.text.length();
	if text_visible >= chars:
		text_visible = 0.0;
		dialogue = intro_cutscene_dialogue[dialogue["next"]];
		text_label.text = dialogue["text"];
		speaker_label.text = dialogue["speaker"];
	else:
		text_visible = chars;
		text_label.visible_characters = text_visible;

# Configure speech box
func configure(_dialogue):
	# Grab focus
	grab_focus();
	
	#Testing
	dialogue = intro_cutscene_dialogue[0];
	
	# Enable speech box
	visible = true;
	process_mode = Node.PROCESS_MODE_INHERIT;
	
	# Set text
	speaker_label.text = dialogue["speaker"];
	text_label.text = dialogue["text"];
	
	# Play animation
	AP.play("begin");
	
	# Animate characters appearing
	text_label.visible_characters = 0;
