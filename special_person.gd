extends NPC
signal you_found_me

func reaction() -> void:
	$GivingChance.start()

func _on_giving_chance_timeout() -> void:
	disgusted = true
	disgusted_timer.start(3)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("interact") && selected:
		print("i like you, you may have won")
		you_found_me.emit()
