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

func _process(delta: float) -> void:
	if main.is_dialog:
		event_label.visible = false
		smoke_label.visible = false


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
		else:
			fox.visible = false
			smoke_label.visible = false
			is_smoking = false
			fox.stop()
			think_bubble.visible = false
			get_tree().call_group("player", "stand")
			
func set_day(day: int):
	match day:
		2:
			dog.visible = true
			
func dog_talk(text,time):
	await dog_talk_bubble.start_typing("Hi, Fo", 2)
		
func fox_think(text, time):
	await think_bubble.start_typing(text,time)

func fox_talk(text, time):
	await fox_talk_bubble.start_typing(text,time)
