class_name Player extends CharacterBody2D
signal interaction
signal use_item

@onready var head: Sprite2D = %Head
@export var base_speed: float = 40
var speed = base_speed
var direction:Vector2 = Vector2.ZERO;
var items: Array[bool] = [false, false, false]

func _ready() -> void:
	main.player = self

func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("left","right")
	direction.y = Input.get_axis("up","down")
	if(direction != Vector2.ZERO && main.SceneSwitcher.playSound):
		main.SceneSwitcher.sounds.play()
		main.SceneSwitcher.playSound = false
	if direction.x == 1:
		$Head.frame_coords.x = 1
		$Body.frame_coords.x = 1
		$Shoes.frame_coords.x = 1
	elif direction.x == -1:
		$Head.frame_coords.x = 2
		$Body.frame_coords.x = 2
		$Shoes.frame_coords.x = 2
	elif direction.y == 1:
		$Head.frame_coords.x = 0
		$Body.frame_coords.x = 0
		$Shoes.frame_coords.x = 0
	elif direction.y == -1:
		$Head.frame_coords.x = 3
		$Body.frame_coords.x = 3
		$Shoes.frame_coords.x = 3
	velocity = direction.normalized()*speed
	move_and_slide()
	if main.belonging <= 0:
		main.SceneSwitcher.lose()

func unmask() -> void:
	if head.frame_coords.y == 0: return
	head.frame_coords.y = 0
	speed = 0
	await get_tree().create_timer(2).timeout
	head.frame_coords.y = 1
	speed = base_speed

func _on_man_npc_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

func interact():
	interaction.emit()

func changeClothes(cloth:String):
	match cloth:
		"mask":
			items[0] = true
		"tie":
			items[1] = true
		"shoes":
			items[2] = true

func _input(event: InputEvent) -> void:
	if event.is_action("use"):
		if items[0]:
			use_item.emit()
			$Head.frame_coords.y = 2
			items[0] = false
		if items[1]:
			use_item.emit()
			$Body.frame_coords.y = 1
			items[1] = false
		if items[2]:
			use_item.emit()
			$Shoes.frame_coords.y = 1
			items[2] = false
