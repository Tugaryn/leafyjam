extends Sprite2D

func _ready() -> void:
	var tween = create_tween()
	var float_number = randf_range(0.005, 0.01)
	tween.set_loops(-1)  # -1 для бесконечного цикла
	tween.tween_property(self, "scale", Vector2(1.02 - float_number,1.02 - float_number), 5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "scale", Vector2(1.0,1.0), 5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.play()
