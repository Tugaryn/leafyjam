extends Sprite2D

@onready var label = $Label
@onready var sound = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_typing(text):
	visible = true
	sound.play()
	await label.start_typing(text)
	await get_tree().create_timer(1).timeout
	label.text = ""
	visible = false
