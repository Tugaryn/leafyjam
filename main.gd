extends Node2D

@onready var count_day = 1
@onready var interlude = $Interlude
@onready var dog = $Dog
@onready var fox = $Fox
@onready var mailbox = $Mailbox
@onready var bench = $Bench
@onready var house = $House
@onready var harp = $Harp

@onready var back = $Back
@onready var front = $Front

@onready var is_nothing_happens = false
@onready var number_cigaretes = 2
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

@onready var title = $Title
@onready var thanks = $Thanks


func _ready() -> void:
	add_child(dialog_service)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	is_interlude = true
	await interlude.execute()
	is_interlude = false
	await get_tree().create_timer(1).timeout
	const FIRST_DIALOG = [
	{
		"type": 0, "who":0, "text": "Need a smoke", "time": 2,
	},
		{
		"type": 0, "who":0, "text": "Two cigarettes left", "time": 1,
	},
]
	#await execute_dialog(FIRST_DIALOG)
	
	crow_timer.start(20)
	owl_timer.start(5)
	bird_timer_1.start(10)
	bird_timer_2.start(30)

	
func execute_dialog(array: Array):
	await dialog_service.execute(array)
	
func execute_last_scene():
	audio_harp.play()
	await dialog_service.execute([
	{
		"type": 0, "who":0, "text": "...", "time": 2, "is_bench": true,
	},
		{
		"type": 0, "who":0, "text": "...", "time": 2, "is_bench": true,
	},
])
	back.find_child("Clouds").visible = false
	back.find_child("BackTree").visible = false
	await get_tree().create_timer(1).timeout
	await dialog_service.execute([
	{
		"type": 0, "who":0, "text": "I won't smoke all autumn", "time": 2, "is_bench": true,
	},
		{
		"type": 0, "who":0, "text": "...", "time": 2, "is_bench": true,
	},
])
	front.visible = false

	await get_tree().create_timer(4).timeout

	await dialog_service.execute([
	{
		"type": 0, "who":0, "text": "I wonder if I'm blooming or fading", "time": 2, "is_bench": true,
	},
		{
		"type": 0, "who":0, "text": "...", "time": 2, "is_bench": true,
	},
])
	back.find_child("Pines").visible = false
	back.find_child("Trees").visible = false
	back.find_child("Particles").visible = false
	await get_tree().create_timer(4).timeout

	await dialog_service.execute([
	{
		"type": 0, "who":0, "text": "When does autumn end?", "time": 2, "is_bench": true,
	},
		{
		"type": 0, "who":0, "text": "When the last leaf falls?", "time": 2, "is_bench": true,
	},
])
	back.find_child("Bunches").visible = false
	await get_tree().create_timer(4).timeout

	await dialog_service.execute([
	{
		"type": 0, "who":0, "text": "Or when the last leaf is swept away?", "time": 2, "is_bench": true,
	},
])
	mailbox.visible = false
	house.visible = false
	await get_tree().create_timer(4).timeout

	await dialog_service.execute([
	{
		"type": 0, "who":0, "text": "All that's left of tobacco is the taste of burnt rubber", "time": 2, "is_bench": true,
	},
		{
		"type": 0, "who":0, "text": "...", "time": 2, "is_bench": true,
	},
])
	await get_tree().create_timer(4).timeout

	await dialog_service.execute([
	{
		"type": 0, "who":0, "text": "I dreamt today that I was sweeping a clean path", "time": 2, "is_bench": true,
	},
])
	title.visible = true
	await get_tree().create_timer(4).timeout
	thanks.visible = true




	
func execute_alone_dialog_day_4():
	pass
	
func execute_alone_dialog_day_7():
	await get_tree().create_timer(1).timeout
	const DIALOG = [
		{
		"type":1, "who":0, "text": "I heard the sound of the harp today", "time": 2, "flip": true, 
	},
]
	await dialog_service.execute(DIALOG)

func execute_first_do_dialog():
	await get_tree().create_timer(1).timeout
	const DIALOG = [
		{
		"type": 1, "who":1, "text": "Hi", "time": 2, "is_bench": true, 
	},
		{
		"type": 1, "who":0, "text": "Hi", "time": 2,"flip": true
	},
		{
		"type": 1, "who":1, "text": "...", "time": 2, "is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "Did you bring cigarettes?", "time": 2,"flip": true
	},
		{
		"type": 1, "who":1, "text": "Yeap", "time": 2, "is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "What?", "time": 2,"flip": true
	},
		{
		"type": 1, "who":1, "text": "New. ‘The Gathering’", "time": 2, "is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "...", "time": 2,"flip": true
	},
]
	await dialog_service.execute(DIALOG)

func execute_second_do_dialog():
	await get_tree().create_timer(1).timeout
	const DIALOG = [
		{
		"type": 1, "who":1, "text": "Hi", "time": 2, "is_bench": true, 
	},
		{
		"type": 1, "who":0, "text": "Hi", "time": 2,"flip": true
	},
		{
		"type": 1, "who":0, "text": "I wrote four lines today", "time": 2,"flip": true
	},
		{
		"type": 1, "who":1, "text": "Good or bad?", "time": 2, "is_bench": true,
	},
	{
		"type": 1, "who":0, "text": "Don't know, I liked them", "time": 2,"flip": true
	},
		{
		"type": 1, "who":1, "text": "Read it?", "time": 2, "is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "I didn't like them that much", "time": 2,"flip": true
	},
]
	await dialog_service.execute(DIALOG)

func execute_third_do_dialog():
	await get_tree().create_timer(1).timeout
	const DIALOG = [
		{
		"type": 1, "who":1, "text": "Hi", "time": 2, "is_bench": true, 
	},
		{
		"type": 1, "who":0, "text": "Hi", "time": 2,"flip": true
	},
		{
		"type": 1, "who":0, "text": "I dreamt today that I was sweeping a yellow leaf", "time": 2,"flip": true
	},
		{
		"type": 1, "who":1, "text": "Sweeping yellow leaves in a dream... ", "time": 2, "is_bench": true,
	},
	{
		"type": 1, "who":1, "text": "is either a sign of wealth or death", "time": 2, "is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "But I dreamt I was sweeping one leaf. One particular leaf", "time": 2, "flip": true,
	},
		{
		"type": 1, "who":1, "text": "Hmm. Could it mean poverty?", "time": 2,"is_bench": true
	},
			{
		"type": 1, "who":0, "text": "...Or maybe it means I'm almost dead?", "time": 2,"flip": true
	},
				{
		"type": 1, "who":1, "text": "Maybe. The dream is vague", "time": 2,"is_bench": true
	},
			{
		"type": 1, "who":0, "text": "The dream is hazy", "time": 2,"flip": true
	},
]
	await dialog_service.execute(DIALOG)
	
func execute_fourth_do_dialog():
	await get_tree().create_timer(1).timeout
	const DIALOG = [
		{
		"type": 1, "who":1, "text": "Hi", "time": 2, "is_bench": true, 
	},
		{
		"type": 1, "who":0, "text": "Hi", "time": 2,"flip": true
	},
		{
		"type": 1, "who":0, "text": "Did you bring the harp?", "time": 2,"flip": true
	},
		{
		"type": 1, "who":1, "text": "No, I came. It was already here", "time": 2, "is_bench": true,
	},
	{
		"type": 1, "who":0, "text": "Hm", "time": 2, "flip": true,
	},
		{
		"type": 1, "who":1, "text": "Hm", "time": 2, "is_bench": true,
	},
		{
		"type": 1, "who":1, "text": "Do you know how to play?", "time": 2,"is_bench": true
	},
			{
		"type": 1, "who":0, "text": "No", "time": 2,"flip": true
	},
				{
		"type": 1, "who":1, "text": "Me neither", "time": 2,"is_bench": true
	},
]
	await dialog_service.execute(DIALOG)


func set_next_day():
	if !is_nothing_happens:
		is_interlude = true
		#if count_day == 4:
			#audio_harp.stop()
		count_day += 1
		await interlude.execute()
		set_states()
		is_interlude = false
		
		if count_day == 2:
			execute_first_do_dialog()
		if count_day == 3:
			execute_second_do_dialog()
		if count_day == 4:
			execute_alone_dialog_day_4()
		if count_day == 5:
			execute_third_do_dialog()
		if count_day == 6:
			execute_fourth_do_dialog()
			harp.visible = true
		if count_day == 7:
			harp.visible = true
			execute_alone_dialog_day_7()
		#if count_day == 3:
			#audio_harp.play()
	


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
