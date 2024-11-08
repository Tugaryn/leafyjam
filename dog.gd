extends CharacterBody2D


const SPEED = 300.0

@onready var sprite = $AnimatedSprite2D
@onready var talkBubble = $TalkBubble
@onready var thinkBubble = $ThinkBubble

func _ready() -> void:
	visible = false
	await get_tree().create_timer(1).timeout
	think('test')


func talk(text) -> void:
	await talkBubble.start_typing(text)
	
func think(text) -> void:
	await thinkBubble.start_typing(text)

func set_day(day: int):
	match day:
		2:
			visible = true
			
