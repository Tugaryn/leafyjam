extends Node2D

@onready var event_label = $EventLabel
@onready var can_activate = false
@onready var audio_open = $AudioOpen
@onready var main = get_parent()


func _process(delta: float) -> void:
	if main.is_dialog:
		event_label.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_activate = true
		event_label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_activate = false
		event_label.visible = false

func activate():
	if can_activate and visible:
		event_label.visible = false
		audio_open.play()
