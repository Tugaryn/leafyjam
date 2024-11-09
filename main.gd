extends Node2D

@onready var count_day = 1
@onready var interlude = $Interlude
@onready var dog = $Dog
@onready var fox = $Fox
@onready var mailbox = $Mailbox
@onready var bench = $Bench
@onready var is_nothing_happens = false
@onready var number_cigaretes = 1
@onready var audio_crow = $AudioCrow
@onready var crow_timer = $CrowTimer
@onready var audio_owl = $AudioOwl
@onready var owl_timer = $OwlTimer

@onready var bird_timer_1 = $BirdTimer1
@onready var audio_bird_1 = $AudioBird1

@onready var bird_timer_2 = $BirdTimer2
@onready var audio_bird_2 = $AudioBird2
@onready var dialog_service: DialogService = DialogService.new()

@onready var audio_harp = $AudioHarp

@onready var is_interlude = false
@onready var is_dialog = false


const TEST_DIALOG = [
	{
		"type": 1, "who":0, "text": "Hello", "time": 5, "is_bench": true,
	},
		{
		"type": 1, "who":1, "text": "Hello", "time": 1,
	},
]

func _ready() -> void:
	add_child(dialog_service)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	is_interlude = true
	await interlude.execute()
	is_interlude = false
	
	crow_timer.start(20)
	owl_timer.start(5)
	bird_timer_1.start(10)
	bird_timer_2.start(30)
	
	await execute_dialog(TEST_DIALOG)

	
func execute_dialog(array: Array):
	await dialog_service.execute(array)

	
func set_next_day():
	if !is_nothing_happens:
		is_interlude = true
		if count_day == 4:
			audio_harp.stop()
		count_day += 1
		number_cigaretes = 0
		await interlude.execute()
		set_states()
		is_interlude = false
		if count_day == 3:
			audio_harp.play()
	


func set_states():
	fox.set_day(count_day)
	dog.set_day(count_day)
	mailbox.set_day(count_day)
	bench.set_day(count_day)
	


func _on_crow_timer_timeout() -> void:
	audio_crow.play()
	var number = randi_range(30,55)
	crow_timer.start(number)
	


func _on_owl_timer_timeout() -> void:
	audio_owl.play()
	var number = randi_range(20,33)
	owl_timer.start(number)


func _on_bird_timer_1_timeout() -> void:
	audio_bird_1.play()
	var number = randi_range(20,60)
	bird_timer_1.start(number)


func _on_bird_timer_2_timeout() -> void:
	audio_bird_2.play()
	var number = randi_range(30,65)
	bird_timer_2.start(number)
