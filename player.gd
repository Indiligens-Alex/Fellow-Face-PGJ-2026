class_name Player extends CharacterBody2D
signal unmasked

var direction:Vector2 = Vector2.ZERO;

@export var base_speed: float = 15
var speed = base_speed
@onready var sprite: Sprite2D = %Sprite

func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("left","right")
	direction.y = Input.get_axis("up","down")
	if Input.is_action_just_pressed("unmask"):
		unmask()
	velocity = direction.normalized()*speed;
	move_and_slide()

func unmask() -> void:
	sprite.frame_coords.y = sprite.frame_coords.y-1
	speed = 0
	unmasked.emit()
	await get_tree().create_timer(2).timeout
	sprite.frame_coords.y = sprite.frame_coords.y+1
	speed = base_speed
