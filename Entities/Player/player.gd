extends CharacterBody2D

@export var speed = 200
@export var item_bar: ItemBar  # assign a Resource in Inspector
@onready var inventory_ui = $ItemBarUI  # the CanvasLayer node

var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size
	if inventory_ui:
		inventory_ui.item_bar = item_bar
		inventory_ui.populate_item_bar()  # now the slots show

func _physics_process(delta: float) -> void:
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
		input_vector = input_vector.normalized() * speed

	velocity = input_vector
	move_and_slide()

	# Clamp inside screen
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
