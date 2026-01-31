extends Node
signal won

@onready var special_npc: PackedScene = preload("res://special_person.tscn")

@onready var player: Player = $"../Player"
var all_npcs: Array

func _ready() -> void:
	for npc: NPC in get_children():
		npc.got_disgusted.connect(player.unmask)
		all_npcs.append(npc)
	
	#for i in range(3): 
	var bozo: NPC = all_npcs.pick_random()
	var chad = special_npc.instantiate()
	chad.global_position = bozo.global_position
	bozo.queue_free()
	remove_child(bozo)
	add_child(chad)
	chad.you_found_me.connect(win)

func win():
	for npc: Node2D in all_npcs:
		npc.set_script(null)
	won.emit()
