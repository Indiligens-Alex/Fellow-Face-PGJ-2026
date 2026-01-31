class_name Player extends CharacterBody2D
signal interaction

@onready var head: Sprite2D = %Head
@export var base_speed: float = 40
var speed = base_speed
var direction:Vector2 = Vector2.ZERO;

func _ready() -> void:
	main.player = self

func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("left","right")
	direction.y = Input.get_axis("up","down")
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
	if main.isolation >= 100:
		lose()

func unmask() -> void:
	head.frame_coords.y -= 1
	speed = 0
	await get_tree().create_timer(2).timeout
	head.frame_coords.y += 1
	speed = base_speed

func _on_man_npc_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

func lose():
	print(":(")

func interact():
	interaction.emit()
	unmask()
func changeClothes(cloth:String):
	match cloth:
		"mask":
			$Head.frame_coords.y = 1
		"tie":
			$Body.frame_coords.y = 1
		"shoes":
			$Shoes.frame_coords.y = 1
