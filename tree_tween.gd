extends Node2D

func _ready() -> void:
	var sprites = get_children()
	sprites.pop_front()
	for sprite in sprites:
		animate_leaves(sprite)
#
func animate_leaves(sprite: Sprite2D):
	var tween = create_tween()
	var number = randi_range(-2, 2)
	var float_number = randf_range(0.005, 0.01)
	tween.set_loops(-1)  # -1 для бесконечного цикла
	tween.tween_property(sprite, "scale", Vector2(1.02 - float_number,1.02 - float_number), 5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(sprite, "scale", Vector2(1.0,1.0), 5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	#tween.tween_property(sprite, "transform", 5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	#tween.tween_property(sprite, "scew", 0.9, 5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.play()
	var tween_2 = create_tween()
	tween_2.set_loops(-1)
	tween_2.tween_property(sprite, "rotation_degrees", -2 + number, 10).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween_2.tween_property(sprite, "rotation_degrees", +2 + number, 10).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween_2.play()
