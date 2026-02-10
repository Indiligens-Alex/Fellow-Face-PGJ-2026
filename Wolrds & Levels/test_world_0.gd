extends Node

enum GameState { Game, Win, Lose }
var state: GameState = GameState.Game

@onready var player: Player = $Player
@onready var npc_collection: Node = %"NPC Collection"

func _ready() -> void:
	npc_collection.won.connect(game_win)

func game_win():
	pass
