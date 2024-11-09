extends Sprite2D

@onready var label = $Label
@onready var sound = $Audio

@onready var main = get_parent().get_parent()

var is_typing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_typing(text , time = 1):
	main.is_dialog = true
	if is_typing:
		return
	is_typing = true
	sound.play()
	visible = true
	sound.play()
	await label.start_typing(text)
	await get_tree().create_timer(time).timeout
	label.text = ""
	visible = false
	is_typing = false
	main.is_dialog = false
