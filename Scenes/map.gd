extends Node2D
var spawn:Node2D 
func _ready() -> void:
	spawn = get_tree().get_nodes_in_group("spawner")[main.random.randi_range(0,4)]
	spawn.spawn_friend()
