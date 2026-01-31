class_name NPC extends CharacterBody2D

var destination: Vector2
var dir: Vector2
@export var walk_time: float = 1
@export var search_radius: float = 5
@onready var cooldown_timer: Timer = %"Cooldown Timer"
@onready var man: Sprite2D = %Man

func _ready() -> void:
	var rand_offset: Vector2 = Vector2(randf_range(-5, 5), randf_range(-2, 5.5))
	position += rand_offset
	cooldown_timer.timeout.connect(walk_around)
	walk_around()

func walk_around() -> void:
	destination = global_position + Vector2(randf_range(-search_radius, search_radius), randf_range(-search_radius, search_radius))
	var t: Tween = create_tween()
	turn_sprite()
	t.tween_property(self, "global_position", destination, walk_time)
	start_cooldown()

func start_cooldown() -> void:
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
	
