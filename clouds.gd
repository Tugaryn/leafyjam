extends Node2D

var screen_limit: float = 1280.0
var direction = 1

func _ready() -> void:
	var sprites = get_children()
	sprites.pop_front()
	for sprite in sprites:
		move_cloud(sprite)		
		

func move_cloud(sprite: Sprite2D) -> void:
	var tween = create_tween()
	tween.set_loops()
	var speed = randi_range(5,10)
	if sprite.flip_h:
		direction = -1
	
	var duration = (2 * screen_limit) / speed
	tween.tween_property(sprite, "position:x", screen_limit * direction, duration)
	tween.tween_callback(_on_tween_finished)

func _on_tween_finished() -> void:
	position.x = screen_limit * direction * -1
