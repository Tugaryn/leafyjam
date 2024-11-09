extends CharacterBody2D


const SPEED = 300.0

@onready var sprite = $AnimatedSprite2D
@onready var talkBubble = $DogTalkBubble

func _ready() -> void:
	await get_tree().create_timer(1).timeout


func talk(text, time = 1) -> void:
	await talkBubble.start_typing(text)

func set_day(day: int):
	pass
