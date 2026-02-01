extends Control

func _process(delta: float) -> void:
	$ProgressBar.value = 100 - main.belonging
