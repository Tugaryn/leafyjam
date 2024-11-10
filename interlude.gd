extends Node2D

@onready var main = get_parent()
@onready var label = $Label
@onready var title = $Title
@onready var audio_close = $AudioClose

func _ready() -> void:
	visible = false

func execute():

	label.text ="The " + str(main.count_day) + " day"
	visible = true
	var time
	if main.count_day == 1:
		await get_tree().create_timer(2).timeout
		title.visible = true
		await get_tree().create_timer(2).timeout
		label.visible = true
		time = 4
	else:
		title.visible = false
		label.visible = true
		time = 3
	
	await get_tree().create_timer(time).timeout
	audio_close.play()
	await audio_close.finished
	visible = false
