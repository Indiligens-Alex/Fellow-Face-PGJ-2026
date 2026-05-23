extends Node2D
@export var radius:float
@export var corridor_id:int
#@export var canFriend:bool;
#@export var itemPointer:Vector2
var enemy:=  preload("res://man_npc.tscn")
var friend:=  preload("res://special_person.tscn")
var random_vector := Vector2.ZERO
var min = 10
var max = 15
func _ready() -> void:
	print(position)
	for i in main.random.randi_range(1,1):
		spawn()
func spawn():
	random_vector = Vector2(main.random.randf_range(-radius,radius),main.random.randi_range(-radius,radius))
	var instance = enemy.instantiate()
	instance.position = position + random_vector
	instance.corridor = corridor_id
	get_parent().add_child.call_deferred(instance)
func spawn_friend():
	random_vector = Vector2(main.random.randf_range(-radius,radius),main.random.randi_range(-radius,radius))
	var instance = friend.instantiate()
	instance.position = position + random_vector
	instance.corridor = corridor_id
	#while itemPointer.distance_to(instance.position) > 100:
		#random_vector = Vector2(main.random.randf_range(-radius,radius),main.random.randi_range(-radius,radius))
		#instance.position = position + random_vector
	print("friend pos:", instance.position)
	get_parent().add_child.call_deferred(instance)
