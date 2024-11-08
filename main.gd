extends Node2D

@onready var count_day = 1
@onready var interlude = $Interlude
@onready var dog = $Dog
@onready var fox = $Fox
@onready var is_nothing_happens = false


func _ready() -> void:
	pass
	
	
func set_next_day():
	if !is_nothing_happens:
		count_day += 1
		await interlude.execute()
		set_states()


func set_states():
	fox.set_day(count_day)
	dog.set_day(count_day)
	
