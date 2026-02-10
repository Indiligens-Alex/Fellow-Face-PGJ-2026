extends "res://interactable.gd"
var interactable = true
var poses:Array[Vector2] = [Vector2(-320,253),Vector2(-386,253),Vector2(-386,300),Vector2(-410,30),Vector2(-410,197),Vector2(310,197),Vector2(-310,253)]
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if interacting && interactable && Input.is_action_just_pressed("interact"):
		interactable = false
		$AnimationPlayer.play("move")
		main.player.use_item.emit()
		sound.play()
