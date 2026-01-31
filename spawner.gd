extends Node2D
@export var radius:float
var enemy:=  preload("res://man_npc.tscn")
var random_vector := Vector2.ZERO

func _ready() -> void:
	print(position)
	for i in main.random.randi_range(10,30):
		spawn()
func spawn():
	random_vector = Vector2(main.random.randf_range(-radius,radius),main.random.randi_range(-radius,radius))
	var instance = enemy.instantiate()
	instance.position = position + random_vector
	print("spawn",position,"pos:",instance.position)
	get_parent().add_child.call_deferred(instance)
