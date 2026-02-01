extends Node2D
var spawn:Node2D 
func _ready() -> void:
	var canFriend = false;
	while !canFriend:
		spawn = get_tree().get_nodes_in_group("spawner")[main.random.randi_range(0,4)]
		canFriend = spawn.canFriend
		print(spawn, spawn.canFriend)
	spawn.spawn_friend()
