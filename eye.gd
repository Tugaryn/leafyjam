extends AnimatedSprite2D

@export var time: int = 10

@onready var timer = $Timer

func _ready() -> void:
	timer.wait_time = time

func _on_timer_timeout() -> void:
	play("light")
	timer.start(time + 5)
