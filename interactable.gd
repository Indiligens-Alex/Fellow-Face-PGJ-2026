extends Area2D
var interacting:bool = false;
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$Sprite2D.set_instance_shader_parameter("active", true)
		interacting = true


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		interacting = false
		$Sprite2D.set_instance_shader_parameter("active", false)



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if interacting && Input.is_action_just_pressed("interact"):
		print("interacted")
		main.player.interact()
