extends Node2D

@onready var event_label = $EventLabel
@onready var smoke_label = $SmokeLabel
@onready var fox = $Fox
@onready var dog = $Dog
@onready var can_activate = false
@onready var is_smoking = false
@onready var main = get_parent()
@onready var audio_lighter = $AudioLighter
@onready var audio_sit = $AudioSit

@onready var think_bubble = $ThinkBubble
@onready var dog_talk_bubble = $DogTalkBubble
@onready var fox_talk_bubble = $FoxTalkBubble

@onready var first_dialog_count = 0
@onready var alone_dialog_count_1 = 0
@onready var first_sit_with_do_count = 0
@onready var talk_with_do_day_3_count = 0
@onready var alone_dialog_count_day_4 = 0
@onready var talk_with_do_day_5_count = 0
@onready var talk_with_do_day_6_count = 0

func _ready() -> void:
	dog.visible = true
	dog.play("default")



func _process(delta: float) -> void:
	if main.is_dialog:
		event_label.visible = false
		smoke_label.visible = false
	else:
		if main.count_day == 1 and fox.visible:
			await get_tree().create_timer(6).timeout
			if !main.is_dialog:
				think_fox_alone()
		elif main.count_day == 2 and fox.visible and first_sit_with_do_count > 1:
			await get_tree().create_timer(3).timeout
			if !main.is_dialog:
				talk_with_do_day_1()
		elif main.count_day == 3 and fox.visible:
			await get_tree().create_timer(3).timeout
			if !main.is_dialog:
				talk_with_do_day_3()
		elif main.count_day == 4 and fox.visible:
			await get_tree().create_timer(3).timeout
			if !main.is_dialog:
				think_fox_alone_day_4()
		elif main.count_day == 5 and fox.visible:
			await get_tree().create_timer(3).timeout
			if !main.is_dialog:
				talk_with_do_day_5()
		elif main.count_day == 6 and fox.visible:
			await get_tree().create_timer(3).timeout
			if !main.is_dialog:
				talk_with_do_day_6()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("smoke") and fox.visible and !is_smoking:
		smoke_label.visible = false
		if main.number_cigaretes > 0:
			main.number_cigaretes -= 1
			fox.play("start_smoke")
			is_smoking = true
			audio_lighter.play()
			await get_tree().create_timer(1).timeout
			fox.play("smoke")
			get_tree().create_timer(3).timeout.connect(think_first_smoke)
			get_tree().create_timer(3).timeout.connect(first_sit_with_do)

			await get_tree().create_timer(20).timeout
			fox.play("default")
			is_smoking = false
		else:
			await think_bubble.start_typing("No more cigarettes")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_activate = true
		event_label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_activate = false
		event_label.visible = false

func activate():
	if can_activate:
		if !fox.visible:
			fox.visible = true
			smoke_label.visible = true
			event_label.visible = false
			fox.play("default")
			audio_sit.play()
			get_tree().call_group("player","sit")
			first_sit_with_do()
			#await main.execute_last_scene()
			if main.count_day == 7:
				main.execute_last_scene()
			
		elif !main.is_dialog and main.count_day != 7:
			fox.visible = false
			smoke_label.visible = false
			is_smoking = false
			fox.stop()
			think_bubble.visible = false
			get_tree().call_group("player", "stand")
			
func set_day(day: int):
	match day:
		1:
			dog.visible = true
			dog.play("default")
		2:
			dog.visible = true
			dog.play("default")
		4:
			dog.visible = false
		5:
			dog.visible = true
		7:
			dog.visible = false
			
func dog_talk(text,time):
	await dog_talk_bubble.start_typing(text, time)
		
func fox_think(text, time):
	await think_bubble.start_typing(text,time)

func fox_talk(text, time):
	await fox_talk_bubble.start_typing(text,time)
	
func think_first_smoke():
	pass
	#if main.count_day == 1 and first_dialog_count == 0 and !main.is_dialog:
		#const FIRST_SMOKE_DIALOG = [
			#{
				#"type": 0, "who":0, "text": "Two lines written today", "time": 2, "is_bench": true,
			#},
				#{
				#"type": 0, "who":0, "text": "More than I did yesterday", "time": 2, "is_bench": true,
			#},
					#{
				#"type": 0, "who":0, "text": "Wonder when Do will come?", "time": 2, "is_bench": true,
			#},
					#{
				#"type": 0, "who":0, "text": "Cigarettes are running out", "time": 2, "is_bench": true,
			#},
		#]
		#if fox.visible:
			#first_dialog_count += 1
			#main.execute_dialog(FIRST_SMOKE_DIALOG)
			
func first_sit_with_do():
	if main.count_day == 2 and !main.is_dialog and first_sit_with_do_count == 0:
		const DIALOG = [		{
		"type": 1, "who":1, "text": "Take it", "time": 1, "is_bench": true, 
	},
		{
		"type": 0, "who":0, "text": "*Got 3 cigarettes*", "time": 2,"is_bench": true,
	},
			{
		"type": 0, "who":0, "text": "Hmm. Let's smoke", "time": 2,"is_bench": true,
	}
	]
		if fox.visible:
			first_sit_with_do_count += 1
			main.number_cigaretes += 3
			main.execute_dialog(DIALOG)
	elif main.count_day == 2 and !main.is_dialog and first_sit_with_do_count == 1:
		const DIALOG = [		{
		"type": 1, "who":1, "text": "How's that?", "time": 1, "is_bench": true, 
	},
		{
		"type": 1, "who":0, "text": "Okay. I haven't smoked in 24 hours", "time": 2, "is_bench": true,
	},
		{
		"type": 1, "who":1, "text": "How do they taste? Describe them", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "You quit smoking", "time": 2, "is_bench": true,
	},
		{
		"type": 1, "who":1, "text": "Quit, but I still love the taste", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":1, "text": "If you describe them, I'll smoke them in my imagination", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "Pumpkin-flavoured burnt rubber", "time": 1, "is_bench": true,
	},
		{
		"type": 1, "who":1, "text": "...Like ~Kamel~? ", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "Like ~Kamel~", "time": 1, "is_bench": true,
	},
	]
		if fox.visible:
			first_sit_with_do_count += 1
			main.execute_dialog(DIALOG)
			
func talk_with_do_day_1():
	if main.count_day == 2 and !main.is_dialog and first_sit_with_do_count == 2:
		const DIALOG = [		{
		"type": 0, "who":1, "text": "How's your poetry?", "time": 1, "is_bench": true, 
	},
		{
		"type": 0, "who":0, "text": "Wrote two lines in the morning", "time": 2,"is_bench": true,
	},
			{
		"type": 0, "who":0, "text": "Didn't write in the evening", "time": 2,"is_bench": true,
	},
		{
		"type": 0, "who":0, "text": "Won't make it to the end of autumn", "time": 2,"is_bench": true,
	},
		{
		"type": 0, "who":1, "text": "...", "time": 2,"is_bench": true,
	},
		{
		"type": 0, "who":1, "text": "Shall we go into town?", "time": 2,"is_bench": true,
	},
	{
		"type": 0, "who":0, "text": "I like silence", "time": 2,"is_bench": true,
	},
		{
		"type": 0, "who":1, "text": "It's autumn. It's quiet everywhere", "time": 2,"is_bench": true,
	},
	{
		"type": 0, "who":0, "text": "In the city in the morning I'd write a couple of poems", "time": 2,"is_bench": true,
	},
			{
		"type": 0, "who":1, "text": "Cool. Go?", "time": 2,"is_bench": true,
	},
	{
		"type": 0, "who":0, "text": "That was an argument against it", "time": 2,"is_bench": true,
	},
	]
		if fox.visible:
			first_sit_with_do_count += 1
			main.execute_dialog(DIALOG)
	elif main.count_day == 2 and !main.is_dialog and first_sit_with_do_count == 3:
		const DIALOG = [	
		{
		"type": 1, "who":0, "text": "Fallen leaves", "time": 2,"is_bench": true,
	},
	{
		"type": 0, "who":0, "text": "Which leaf is more beautiful - the blooming green or the fading yellow?", "time": 2,"is_bench": true,
	},
		{
		"type": 0, "who":1, "text": "It's a matter of mood", "time": 2, "is_bench": true,
	},
		{
		"type": 0, "who":0, "text": "No, a matter of taste", "time": 2,"is_bench": true,
	},
		{
		"type": 0, "who":1, "text": "...", "time": 2, "is_bench": true,
	},
	{
		"type": 0, "who":1, "text": "The fading yellow, of course", "time": 2,"is_bench": true,
	},
		{
		"type": 0, "who":0, "text": "Yeap", "time": 2,"is_bench": true,
	},
	{
		"type": 0, "who":0, "text": "Will go into the house", "time": 2,"is_bench": true,
	},
	{
		"type": 0, "who":1, "text": "See you later", "time": 2,"is_bench": true,
	},
	]
		if fox.visible:
			first_sit_with_do_count += 1
			main.execute_dialog(DIALOG)
	
	
func talk_with_do_day_3():
	if main.count_day == 3 and !main.is_dialog and talk_with_do_day_3_count == 0:
		const DIALOG = [		{
		"type": 1, "who":0, "text": "~and now the power is felt~", "time": 1, "is_bench": true, 
	},
		{
		"type": 1, "who":0, "text": "~Of melancholy, tenderer in its moods~", "time": 2,"is_bench": true,
	},
			{
		"type": 1, "who":0, "text": "~Than any joy indulgent summer dealt~", "time": 2,"is_bench": true,
	},
		{
		"type": 0, "who":1, "text": "beautifully", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "not mine. *Allingham*.", "time": 2,"is_bench": true,
	},
		{
		"type": 0, "who":1, "text": "It's still beautiful", "time": 2,"is_bench": true,
	}
	]
		if fox.visible:
			talk_with_do_day_3_count += 1
			main.execute_dialog(DIALOG)
	if main.count_day == 3 and !main.is_dialog and talk_with_do_day_3_count == 1:
		const DIALOG = [		{
		"type": 0, "who":1, "text": "Do you have dreams?", "time": 2, "is_bench": true, 
	},
		{
		"type": 1, "who":0, "text": "I do", "time": 2,"is_bench": true,
	},
			{
		"type": 1, "who":1, "text": "What do you dream about?", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "*Fields of letters*", "time": 2,"is_bench": true,
	},
	{
		"type": 1, "who":0, "text": "*A rain of dotss*", "time": 1,"is_bench": true,
	},
	{
		"type": 1, "who":0, "text": "*A snowfall of commas*", "time": 1,"is_bench": true,
	},
		{
		"type": 0, "who":1, "text": "Like poetry", "time": 2,"is_bench": true,
	},
	]
		if fox.visible:
			talk_with_do_day_3_count += 1
			main.execute_dialog(DIALOG)
	if main.count_day == 3 and !main.is_dialog and talk_with_do_day_3_count == 2:
		const DIALOG = [		{
		"type": 1, "who":0, "text": "How did you stop smoking?", "time": 2, "is_bench": true, 
	},
		{
		"type": 0, "who":1, "text": "Right now I want to smoke", "time": 2,"is_bench": true,
	},
			{
		"type": 0, "who":1, "text": "But I won't", "time": 2,"is_bench": true,
	},
		{
		"type": 0, "who":1, "text": "I like to feel that I can't give in to the urge", "time": 2,"is_bench": true,
	},
	{
		"type": 1, "who":0, "text": "...", "time": 3,"is_bench": true,
	},
	{
		"type": 0, "who":1, "text": "How did you start smoking?", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "It was boring, only cigarettes for fun", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "At first I just looked at them", "time": 2,"is_bench": true,
	},
			{
		"type": 1, "who":0, "text": "Then I smoked them", "time": 2,"is_bench": true,
	}
	]
		if fox.visible:
			talk_with_do_day_3_count += 1
			main.execute_dialog(DIALOG)
			
	if main.count_day == 3 and !main.is_dialog and talk_with_do_day_3_count == 3:
		const DIALOG = [		{
		"type": 1, "who":0, "text": "I wish autumn wouldn't end", "time": 2, "is_bench": true, 
	},
		{
		"type": 0, "who":1, "text": "Maybe it won't", "time": 2,"is_bench": true,
	},
			{
		"type": 1, "who":0, "text": "It always ends", "time": 2,"is_bench": true,
	},
		{
		"type": 0, "who":1, "text": "What if last summer was the last?", "time": 2,"is_bench": true,
	},
	{
		"type": 0, "who":1, "text": "What if now it'll be autumn forever?", "time": 3,"is_bench": true,
	},
	{
		"type": 1, "who":0, "text": "Then I wish autumn would end", "time": 2,"is_bench": true,
	},
		{
		"type": 0, "who":1, "text": "That makes sense", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "Will go into the house", "time": 2,"is_bench": true,
	},
	{
		"type": 0, "who":1, "text": "See you later", "time": 2,"is_bench": true,
	},
	]
		if fox.visible:
			talk_with_do_day_3_count += 1
			main.execute_dialog(DIALOG)
			
func think_fox_alone():
	if alone_dialog_count_1 == 0:
		const ALONE_DIALOG = [
		{
			"type": 0, "who":0, "text": "...", "time": 2, "is_bench": true,
		},
				{
			"type": 0, "who":0, "text": "How long does autumn last?", "time": 2, "is_bench": true,
		},
						{
			"type": 0, "who":0, "text": "Until all the leaves fall off?", "time": 2, "is_bench": true,
		},
	]
		if fox.visible:
			alone_dialog_count_1 += 1
			main.execute_dialog(ALONE_DIALOG)
	elif alone_dialog_count_1 == 1:
		const ALONE_DIALOG = [
		{
			"type": 0, "who":0, "text": "Need to get inside", "time": 2.5, "is_bench": true,
		},
	]
		if fox.visible:
			alone_dialog_count_1 += 1
			main.execute_dialog(ALONE_DIALOG)
	
func think_fox_alone_day_4():
	if alone_dialog_count_day_4 == 0:
		const ALONE_DIALOG = [
		{
			"type": 0, "who":0, "text": "If I had a broom, I might sweep the leaves", "time": 2, "is_bench": true,
		},
				{
			"type": 0, "who":0, "text": "Yellow leaf. The sun is yellow too", "time": 2, "is_bench": true,
		},
						{
			"type": 0, "who":0, "text": "Maybe it's fading too", "time": 2, "is_bench": true,
		},
	]
		if fox.visible:
			alone_dialog_count_day_4 += 1
			main.execute_dialog(ALONE_DIALOG)
	elif alone_dialog_count_day_4 == 1:
		const ALONE_DIALOG = [
		{
			"type": 0, "who":0, "text": "Eyes in the dark", "time": 2.5, "is_bench": true,
		},
				{
			"type": 0, "who":0, "text": "They're not looking at me", "time": 2.5, "is_bench": true,
		},
				{
			"type": 0, "who":0, "text": "They're looking at the leaves", "time": 2.5, "is_bench": true,
		},
				{
			"type": 0, "who":0, "text": "Need to get inside", "time": 2.5, "is_bench": true,
		},
						{
			"type": 0, "who":0, "text": "Autumn will never end", "time": 2.5, "is_bench": true,
		},
	]
		if fox.visible:
			alone_dialog_count_day_4 += 1
			main.execute_dialog(ALONE_DIALOG)
		

func talk_with_do_day_5():
	if main.count_day == 5 and !main.is_dialog and talk_with_do_day_5_count == 0:
		const DIALOG = [		{
		"type": 1, "who":0, "text": "I wonder what a harp sounds like", "time": 2, "is_bench": true, 
	},
		{
		"type": 1, "who":0, "text": "Imagine what a falling leaf would sound like?", "time": 2,"is_bench": true,
	},
			{
		"type": 0, "who":1, "text": "Like a harp?", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "Yes", "time": 2,"is_bench": true,
},
	]
		if fox.visible:
			talk_with_do_day_5_count += 1
			main.execute_dialog(DIALOG)
	if main.count_day == 5 and !main.is_dialog and talk_with_do_day_5_count == 1:
		const DIALOG = [		{
		"type": 1, "who":0, "text": "Yesterday I was walking up and down", "time": 2, "is_bench": true, 
	},
		{
		"type": 1, "who":0, "text": "Through smoke I saw eyes the colour of fallen leaves", "time": 2,"is_bench": true,
	},
			{
		"type": 1, "who":0, "text": "We looked at each other", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "And when I finished my cigarette they flew away to the crows' cries", "time": 2,"is_bench": true,
},
			{
		"type": 1, "who":1, "text": "Write a poem about it", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "It's an intimate moment", "time": 2,"is_bench": true,
},
		{
		"type": 1, "who":0, "text": "Eyes won't understand", "time": 2,"is_bench": true,
},
	]
		if fox.visible:
			talk_with_do_day_5_count += 1
			main.execute_dialog(DIALOG)
	if main.count_day == 5 and !main.is_dialog and talk_with_do_day_5_count == 2:
		const DIALOG = [		{
		"type": 1, "who":1, "text": "I heard the sound of the harp today", "time": 2, "is_bench": true, 
	},
		{
		"type": 1, "who":1, "text": "Why does the harp only sound in autumn?", "time": 2,"is_bench": true,
	},
			{
		"type": 1, "who":0, "text":  "Because the harp can only be played in autumn", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":1, "text": "Why?", "time": 2,"is_bench": true,
},
			{
		"type": 1, "who":0, "text": "Dont know", "time": 2,"is_bench": true,
	},
			{
		"type": 1, "who":0, "text": "Will go into the house", "time": 2,"is_bench": true,
	},
	{
		"type": 0, "who":1, "text": "See you later", "time": 2,"is_bench": true,
	},
	]
		if fox.visible:
			talk_with_do_day_5_count += 1
			main.execute_dialog(DIALOG)


func talk_with_do_day_6():
	if main.count_day == 6 and !main.is_dialog and talk_with_do_day_6_count == 0:
		const DIALOG = [		{
		"type": 1, "who":0, "text": "The harp is still here", "time": 2, "is_bench": true, 
	},
		{
		"type": 1, "who":0, "text": "It just appeared", "time": 2,"is_bench": true,
	},
			{
		"type": 1, "who":0, "text": "I wonder if this house, the letterbox, the bench...", "time": 2,"is_bench": true,
	},
				{
		"type": 1, "who":0, "text": "...have they always been here?", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "Or did they just appear too?", "time": 2,"is_bench": true,
},
		{
		"type": 1, "who":1, "text": "...", "time": 2,"is_bench": true,
},
	]
		if fox.visible:
			talk_with_do_day_6_count += 1
			main.execute_dialog(DIALOG)
	if main.count_day == 6 and !main.is_dialog and talk_with_do_day_6_count == 1:
		main.number_cigaretes += 20
		const DIALOG = [		{
		"type": 1, "who":1, "text": "I'm leaving tomorrow until winter", "time": 2, "is_bench": true, 
	},
		{
		"type": 1, "who":0, "text": "Where to?", "time": 2,"is_bench": true,
	},
			{
		"type": 1, "who":1, "text": "To my parents", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":1, "text": "You're not the only one who needs cigarettes, huh?", "time": 2,"is_bench": true,
},
		{
		"type": 1, "who":9, "text": "...", "time": 2,"is_bench": true,
},
		{
		"type": 1, "who":1, "text": "I bought you a pack", "time": 2,"is_bench": true,
	},
			{
		"type": 0, "who":0, "text": "*Got 20 cigarettes*", "time": 2,"is_bench": true,
	},
		{
		"type": 1, "who":0, "text": "You think I'm gonna quit smoking?", "time": 2,"is_bench": true,
},
		{
		"type": 1, "who":1, "text": "Either quit smoking or go to the city, it's a win-win", "time": 2,"is_bench": true,
},
		{
		"type": 1, "who":0, "text": "Win-win...", "time": 2,"is_bench": true,
},
		{
		"type": 1, "who":0, "text": "See you in the winter", "time": 2,"is_bench": true,
	},
	{
		"type": 0, "who":1, "text": "Bye", "time": 2,"is_bench": true,
	},
	]
		if fox.visible:
			talk_with_do_day_6_count += 1
			main.execute_dialog(DIALOG)
