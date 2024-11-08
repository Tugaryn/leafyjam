extends Node2D

@onready var event_label = $EventLabel
@onready var can_activate = false

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
		print('test')
