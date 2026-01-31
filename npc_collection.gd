extends Node

@onready var player: Player = $"../Player"
var npcs

func _ready() -> void:
	for npc: NPC in get_children():
		player.unmasked.connect(npc.reaction)
