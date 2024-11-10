class_name DialogService
extends Node

@onready var main = get_parent()

var fox
var dog
var bench

func _ready() -> void:
	fox = main.find_child("Fox")
	dog = main.find_child("Dog")
	bench = main.find_child("Bench")

func execute(array: Array) -> void:
	main.is_dialog = true
	
	for dialog in array:
		if dialog.has("is_bench") and dialog.is_bench:
			if dialog.who == 0:
				if dialog.type == 0:
					await bench.fox_think(dialog.text, dialog.time)
				else:
					await bench.fox_talk(dialog.text, dialog.time)
			else:
				await bench.dog_talk(dialog.text, dialog.time)
		else:
			if dialog.who == 0:
				if dialog.type == 0:
					await fox.think(dialog.text, dialog.time)
				else:
					var flip = dialog.has("flip") and dialog.flip
					await fox.talk(dialog.text, dialog.time, flip)
			else:
				await dog.talk(dialog.text, dialog.time)
	main.is_dialog = false
