extends NPC

func reaction() -> void:
	$GivingChance.start()

func clicked():
	print("i like you, you may have won")



func _on_giving_chance_timeout() -> void:
	disgusted = true
	disgusted_timer.start(3)
