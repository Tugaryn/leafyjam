extends CharacterBody2D


const SPEED = 250.0

@onready var sprite = $AnimatedSprite2D
@onready var talkBubble = $TalkBubble
@onready var thinkBubble = $ThinkBubble
@onready var is_walking = false
@onready var audio_walking = $AudioWalking
@onready var is_block_movement = false
@onready var main = get_parent()

func _physics_process(delta: float) -> void:
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction and visible and !is_block_movement and !main.is_interlude and !main.is_dialog:
		velocity.x = direction * SPEED
		sprite.play("walk")
		if direction < 0:	
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		is_walking = true
	else:
		is_walking = false
		sprite.flip_h = false
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play('default')
	move_and_slide()

func _ready() -> void:
	pass
	#await get_tree().create_timer(1).timeout
	#think('test')
	
func _process(delta: float) -> void:
	if is_walking:
		if !audio_walking.playing:
			audio_walking.play()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("activate"):
		get_tree().call_group("bench", 'activate')
		get_tree().call_group("house", 'activate')
		get_tree().call_group("mailbox", 'activate')

func sit():
	visible = false
	
func stand():
	visible = true
	
func open_mailbox():
	is_block_movement = true
	await think('*Nothing*')
	is_block_movement = false

func talk(text,time = 1) -> void:
	main.is_dialog = true
	await talkBubble.start_typing(text,time)
	main.is_dialog = false
	
func think(text, time = 1) -> void:
	main.is_dialog = true
	await thinkBubble.start_typing(text,time)
	main.is_dialog = false
	
func set_day(day: int):
	pass
