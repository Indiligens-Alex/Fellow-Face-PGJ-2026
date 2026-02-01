extends Button

func _on_pressed() -> void:
	main.SceneSwitcher.sounds.play()
	main.SceneSwitcher.start_game()
