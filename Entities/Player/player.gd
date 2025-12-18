extends CharacterBody2D

@export var speed = 200
@export var item_bar: ItemBar  # assign a Resource in Inspector
@onready var inventory_ui = $ItemBarUI  # the CanvasLayer node
@onready var anim = $AnimationPlayer

var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size
	if inventory_ui:
		inventory_ui.item_bar = item_bar
		inventory_ui.populate_item_bar()  # now the slots show

func _physics_process(_delta: float) -> void:
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1

	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		play_walk_animation(input_vector)
	else:
		anim.play("idle")

	velocity = input_vector * speed
	move_and_slide()

	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func play_walk_animation(dir: Vector2):
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			anim.play("walk_down")
		else:
			anim.play("walk_down")
	else:
		if dir.y > 0:
			anim.play("walk_down")
		else:
			anim.play("walk_up")
