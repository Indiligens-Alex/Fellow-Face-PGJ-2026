class_name NPC extends Area2D
signal got_disgusted

var disgusted: bool
var destination: Vector2
var dir: Vector2
var player_pos: Vector2
var player: Player
var selected = false
var closeToPlayer = false

@export var walk_time: float = 1
@export var search_radius: float = 12
@onready var cooldown_timer: Timer = %"Cooldown Timer"
@onready var man: Sprite2D = %Man
@onready var disgusted_timer: Timer = %DisgustedTimer
@onready var tolerance: int = randi_range(0, 99)

func _ready() -> void:
	var rand_offset: Vector2 = Vector2(randf_range(-5, 5), randf_range(-2, 5.5))
	position += rand_offset
	cooldown_timer.timeout.connect(walk_around)
	body_entered.connect(check_if_player)
	walk_around()

func check_if_player(node: Node2D) -> void:
	#print(node.name)
	if player != null && node.name == "Player":
		player.interaction.connect(reaction)

func walk_around() -> void:
	var t: Tween = create_tween()
	if not disgusted: 
		find_destination()
		turn_sprite()
		t.tween_property(self, "global_position", destination, walk_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		start_cooldown(false)
	else:
		turn_sprite_digusted()
		t.tween_property(self, "global_position", destination, walk_time/2)
		start_cooldown(true)

func find_destination() -> void:
	var min_x := 24.0
	var max_x := 460.0
	var min_y := 32.0
	var max_y := 240.0

	var offset := Vector2(
		randf_range(-search_radius, search_radius),
		randf_range(-search_radius, search_radius))

	if global_position.y < min_y:
		offset.y = abs(search_radius)
	elif global_position.y > max_y:
		offset.y = -abs(search_radius)

	if global_position.x < min_x:
		offset.x = abs(search_radius)
	elif global_position.x > max_x:
		offset.x = -abs(search_radius)

	destination = global_position + offset
	destination.x = clamp(destination.x, min_x, max_x)
	destination.y = clamp(destination.y, min_y, max_y)

	#print(global_position)

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
		"down":
			man.frame = 0
		"right":
			man.frame = 1
		"left":
			man.frame = 2
		"up":
			man.frame = 3

func turn_sprite_digusted() -> void:
	dir = (global_position - main.player.global_position).normalized()
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
		"down":
			man.frame = 0
			destination = global_position + Vector2(search_radius* [-1,1].pick_random(), search_radius)*2
		"right":
			man.frame = 1
			destination = global_position + Vector2(search_radius, search_radius * [-1,1].pick_random())*2
		"left":
			man.frame = 2
			destination = global_position + Vector2(-search_radius, search_radius * [-1,1].pick_random())*2
		"up":
			man.frame = 3
			destination = global_position + Vector2(search_radius* [-1,1].pick_random(), -search_radius)*2
	
func reaction() -> void:
	if tolerance < 50:
		got_disgusted.emit()
		disgusted = true
		main.belonging -= 5;
		disgusted_timer.start(5)

func _on_disgusted_timer_timeout() -> void:
	disgusted = false

func _on_body_exited(body: Node2D) -> void:
	if main.player != null:
		if body == main.player:
			closeToPlayer = false
			main.player.interaction.disconnect(reaction)
			if selected == true:
				$Man.set_instance_shader_parameter("active", false)
				main.selected = false
				selected == false

func _on_mouse_entered() -> void:
	if main.selected == false && closeToPlayer:
		$Man.set_instance_shader_parameter("active", true)
		main.selected = true
		selected = true

func _on_mouse_exited() -> void:
	if selected == true:
		$Man.set_instance_shader_parameter("active", false)
		main.selected = false
		selected == false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("interact") && selected:
		reaction()
		main.belonging -= 50

func _on_body_entered(body: Node2D) -> void:
	if main.player != null:
		if body == main.player:
			closeToPlayer = true
			main.player.interaction.connect(reaction)
