extends CharacterBody2D
var direction:Vector2 = Vector2.ZERO;

var speed = 15
func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("left","right")
	direction.y = Input.get_axis("up","down")
	if Input.is_action_just_pressed("unmask"):
		$Sprite.frame_coords.y =abs($Sprite.frame_coords.y-1)
	velocity = direction.normalized()*speed;
	move_and_slide()
