extends CharacterBody2D


const SPEED = 300.0

@onready var sprite = $AnimatedSprite2D
@onready var talkBubble = $TalkBubble
@onready var thinkBubble = $ThinkBubble
@onready var is_block_movement = false


func _physics_process(delta: float) -> void:
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction and !is_block_movement:
		velocity.x = direction * SPEED
		sprite.play("walk")
		if direction < 0:	
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		sprite.flip_h = false
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play('default')
	move_and_slide()

func _ready() -> void:
	pass
	#await get_tree().create_timer(1).timeout
	#think('test')
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("activate"):
		get_tree().call_group("bench", 'activate')
		get_tree().call_group("house", 'activate')
		get_tree().call_group("mailbox", 'activate')


func talk(text) -> void:
	await talkBubble.start_typing(text)
	
func think(text) -> void:
	await thinkBubble.start_typing(text)

func set_day(day: int):
	match day:
		2:
			is_block_movement = true
