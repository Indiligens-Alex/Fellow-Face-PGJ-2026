class_name NPC extends CharacterBody2D
signal got_disgusted
var corridor:int = -1;
var goal:int = main.random.randi_range(0,2);
var next:int;
enum States{WANDERING, DISGUSTED,TASK,CORRIDOR,TRANSITION};
var state:States = States.CORRIDOR;
var speed:float = 30
var disgusted: bool
var destination: Vector2
var dir: Vector2 = Vector2.ZERO
var player_pos: Vector2
var player: Player
var selected = false
var closeToPlayer = false
var originalPos:Vector2
@export var walk_time: float = 1
@export var search_radius: float = 30
@onready var cooldown_timer: Timer = %"Cooldown Timer"
@onready var man: Sprite2D = %Man
@onready var disgusted_timer: Timer = %DisgustedTimer
@onready var tolerance: float = randf_range(1, 100)

func _process(delta: float) -> void:
	match state:
		States.WANDERING:
			#print(dir)
			if destination.distance_to(global_position) > 10:
				move_and_slide()
			elif cooldown_timer.is_stopped():
				#print("wandered")
				start_cooldown(false)
		States.DISGUSTED:
				move_and_slide()
				
		States.CORRIDOR:
			move_and_slide()
		States.TRANSITION:
			move_and_slide()
			if global_position.distance_to(destination) < 10:
				print("to corridor")
				next_location()
				state = States.CORRIDOR
func _ready() -> void:
	for area in $MouseInteraction.get_overlapping_areas():
		_on_mouse_interaction_area_entered(area)
	next_location()
	$ToleranceTimer.wait_time = tolerance/100 * 1.5
	originalPos = global_position
	var rand_offset: Vector2 = Vector2(randf_range(-5, 5), randf_range(-2, 5.5))
	global_position += rand_offset
	cooldown_timer.timeout.connect(walk_around)
	#$playerClose.body_entered.connect(check_if_player)
	#walk_around()
	set_tolerance()
	
func set_tolerance():
	pass
func check_if_player(node: Node2D) -> void:
	#print(node.name)
	print("check_if_player")
	if main.player != null && node.name == "Player" && !main.player.use_item.is_connected($ToleranceTimer.start):
		main.player.use_item.connect($ToleranceTimer.start)

func walk_around() -> void:
	find_destination()
	turn_sprite()
	velocity = speed*dir
	#print(dir)
	#elif state == States.DISGUSTED:
		#turn_sprite_digusted()
		##t.tween_property(self, "global_position", destination, walk_time/2)
		#velocity = speed*dir
		#move_and_slide()
		#start_cooldown(true)

func find_destination() -> void:
	var min_x := originalPos.x-50
	var max_x := originalPos.x+50
	var min_y := originalPos.y-50
	var max_y := originalPos.y+50

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
		cooldown_timer.wait_time = randf_range(0.5, 1)
	else:
		cooldown_timer.wait_time = randf_range(2, 6)
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
			man.frame = 1#right
		else:
			man.frame = 2#left
	else:
		if sin_angle < 0:
			man.frame = 3#up
		else:
			man.frame = 0#down
	#match dir_name:
		#"down":
			#man.frame = 0
		#"right":
			#man.frame = 1
		#"left":
			#man.frame = 2
		#"up":
			#man.frame = 3

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
			#destination = global_position + Vector2(search_radius* [-1,1].pick_random(), search_radius)*2
		"right":
			man.frame = 1
			#destination = global_position + Vector2(search_radius, search_radius * [-1,1].pick_random())*2
		"left":
			man.frame = 2
			#destination = global_position + Vector2(-search_radius, search_radius * [-1,1].pick_random())*2
		"up":
			man.frame = 3
			#destination = global_position + Vector2(search_radius* [-1,1].pick_random(), -search_radius)*2
	
func reaction() -> void:
	print("reaction")
	got_disgusted.emit()
	state = States.DISGUSTED;
	main.belonging -= 1;
	turn_sprite_digusted()
	velocity = speed*dir
	disgusted_timer.start()

func _on_disgusted_timer_timeout() -> void:
	#change state
	velocity = Vector2.ZERO
	state = States.WANDERING

func _on_body_exited(body: Node2D) -> void:
	if main.player != null:
		if body == main.player:
			closeToPlayer = false
			if main.player.use_item.is_connected($ToleranceTimer.start):
				main.player.use_item.disconnect($ToleranceTimer.start)
			if selected == true:
				$Man.set_instance_shader_parameter("active", false)
				main.selected = false
				selected = false

func _on_mouse_entered() -> void:
	if main.selected == false && closeToPlayer:
		$Man.set_instance_shader_parameter("active", true)
		main.selected = true
		selected = true

func _on_mouse_exited() -> void:
	if selected == true:
		$Man.set_instance_shader_parameter("active", false)
		main.selected = false
		selected = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("interact") && selected:
		main.player.unmask()
		selected = false
		main.selected = false
		reaction()
		print("a",self)
		main.belonging -= 50

func _on_body_entered(body: Node2D) -> void:
	if main.player != null:
		if body == main.player && !main.player.use_item.is_connected($ToleranceTimer.start):
			closeToPlayer = true
			main.player.use_item.connect($ToleranceTimer.start)
			#main.player.interaction.connect(reaction)

func _on_tolerance_timer_timeout() -> void:
	print(1)
	reaction()
func next_location():
	print("next")
	next = -1;
	var min = main.map.distance[corridor][goal]-1;
	print("map ",corridor,": ",main.map.distance[corridor], " min:", min, " goal: ", goal)
	for i in main.map.distance[corridor].size():
		if  main.map.distance[corridor][i] == 1 && main.map.distance[i][goal] == min:
			next = i;
			break;
	if next == -1:
		print("reached")
		dir = Vector2.ZERO
		velocity = dir*speed
		return
	var next_corridor = main.corridors[corridor]
	print("corridor ",corridor," ",next," ",goal);
	if main.map.distance[corridor][next] != 0:
		if next_corridor.horizontal:
			if main.map.breaks[corridor][next].x > global_position.x:
				#next_corridor.get_node("up").add_child(self)
				dir = Vector2.RIGHT
			else:
				dir = Vector2.LEFT
				#next_corridor.get_node("down").add_child(self)
		else:
			if main.map.breaks[corridor][next].y > global_position.y:
				dir = Vector2.DOWN
				#next_corridor.get_node("up").add_child(self)
			else:
				dir = Vector2.UP
				
		velocity = dir*speed
		print("shmove ",dir)
			#next_corridor.get_node("down").add_child(self)
	#push_error("map error next_location")


func _on_mouse_interaction_area_entered(area: Area2D) -> void:
	if(area.is_in_group("break")):
		print("in",area.corridor.id, next)
	if area.is_in_group("break") && area.corridor.id == next:
		#move to pos
		corridor = area.corridor.id
		print("trans ",area.pos)
		destination = area.pos
		state = States.TRANSITION
		dir = global_position.direction_to(area.pos)
		velocity = dir*speed
	#elif area.get_parent().is_in_group("corridor"):
		#corridor = area.get_parent().id
