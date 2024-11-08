extends Node2D

func _ready() -> void:
	visible = false

func execute():
	visible = true
	await get_tree().create_timer(3).timeout
	visible = false
