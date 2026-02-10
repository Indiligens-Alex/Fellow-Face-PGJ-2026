extends Control
func _physics_process(delta: float) -> void:
	$ProgressBar.value = 100 - main.belonging
