extends CharacterBody2D

@export var walk_speed = 75
@export var sprint_speed = 150
@export var crouch_speed = 30

@onready var animation_player = $AnimationPlayer

var current_speed



func get_input():
	var input_direction = Vector2(Input.get_axis("walk_left","walk_right"), Input.get_axis("walk_up","walk_down"))
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed
	elif Input.is_action_pressed("crouch"):
		current_speed = crouch_speed
	else:
		current_speed = walk_speed

	if input_direction == Vector2.ZERO:
		animation_player.play("RESET")
	else:
		if abs(input_direction.x) > (input_direction.y):
			if input_direction.x > 0:
				animation_player.play("walk_forward")
			else:
				animation_player.play("walk_forward")
		else:
			if input_direction.y > 0:
				animation_player.play("walk_forward")
			else:
				animation_player.play("walk_forward")
	
	velocity = input_direction.normalized() * current_speed

func _physics_process(delta):
	get_input()
	move_and_slide()

@onready var interact_label: Label = $Control/Label
var current_interactions := []
var can_interact := true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if current_interactions:
			can_interact = false
			interact_label.hide()
			
			await current_interactions[0].interact.call()
			can_interact = true

func _process(delta: float) -> void:
	if current_interactions and can_interact:
		current_interactions.sort_custom(_sort_by_nearest)
		if current_interactions[0].is_interactable:
			interact_label.text = current_interactions[0].interact_name
			interact_label.show()
	else:
		interact_label.hide()

func _sort_by_nearest(area1, area2):
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist


func _on_interact_range_area_entered(area: Area2D) -> void:
	current_interactions.push_back(area)
	print("Entered:", area.name)

func _on_interact_range_area_exited(area: Area2D) -> void:
	current_interactions.erase(area)
