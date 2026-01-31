extends Button

func _on_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred("res://test_world0.tscn")
