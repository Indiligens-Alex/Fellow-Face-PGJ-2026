class_name NPC extends Area2D

var disgusted: bool
var destination: Vector2
var dir: Vector2
var player_pos: Vector2

@export var walk_time: float = 1
@export var search_radius: float = 5
@onready var cooldown_timer: Timer = %"Cooldown Timer"
@onready var man: Sprite2D = %Man

func _ready() -> void:
	var rand_offset: Vector2 = Vector2(randf_range(-5, 5), randf_range(-2, 5.5))
	position += rand_offset
	cooldown_timer.timeout.connect(walk_around)
	body_entered.connect(check_if_player)
	walk_around()

func check_if_player(node: Node2D) -> void:
	if node.get_class() == "CharacterBody2D" or "Player":
		disgusted = true
	else:
		disgusted = false

func walk_around() -> void:
	var t: Tween = create_tween()
	if not disgusted: 
		if (global_position + Vector2(randf_range(-search_radius, search_radius), randf_range(-search_radius, search_radius))).y > 32:
			pass
		destination = global_position + Vector2(randf_range(-search_radius, search_radius), randf_range(-search_radius, search_radius))
		turn_sprite()
		t.tween_property(self, "global_position", destination, walk_time)
		start_cooldown(false)
	else:
		destination = global_position + Vector2(search_radius, search_radius)*2
		turn_sprite()
		t.tween_property(self, "global_position", destination, walk_time/2)
		start_cooldown(true)

func start_cooldown(quick: bool) -> void:
	if quick:
		cooldown_timer.wait_time = randf_range(.5, 1)
	else:
		cooldown_timer.wait_time = randf_range(1, 4)
	cooldown_timer.start()

func turn_sprite() -> void:
	dir = (destination - global_position).normalized()
	var angle = dir.angle()
	var cos_angle = rad_to_deg(cos(angle))
	var sin_angle = rad_to_deg(sin(angle))
	var abs_sin = abs(sin_angle)
	var abs_cos = abs(cos_angle)
	var dir_name: String

	if abs_cos > abs_sin: # if direction is mostly to the right
		if cos_angle > 0:
			dir_name = "right"
		else:
			dir_name = "left"
	else:
		if sin_angle < 0:
			dir_name = "up"
		else:
			dir_name = "down"
	match dir_name:
		"up":
			man.frame = 0
		"right":
			man.frame = 1
		"left":
			man.frame = 2
		"up":
			man.frame = 3
	
