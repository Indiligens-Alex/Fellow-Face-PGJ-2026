extends Area2D
var interacting:bool = false;
func _physics_process(delta: float) -> void:
		if Input.is_action_just_pressed("interact") && interacting:
			print("interacted")
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$Sprite2D.set_instance_shader_parameter("active", true)
		interacting = true


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		interacting = false
		$Sprite2D.set_instance_shader_parameter("active", false)
