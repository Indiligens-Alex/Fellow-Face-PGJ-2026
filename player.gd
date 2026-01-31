extends CharacterBody2D
var direction:Vector2 = Vector2.ZERO;
var speed = 150;
func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("left","right")
	direction.y = Input.get_axis("up","down")
	velocity = direction.normalized()*speed;
	move_and_slide()
