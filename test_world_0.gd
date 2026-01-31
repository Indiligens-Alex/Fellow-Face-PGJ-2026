extends Node

enum GameState { Game, Win, Lose }
@onready var button: Button = $Button

var state: GameState = GameState.Game
@onready var player: Player = $Player
@onready var npc_collection: Node = %"NPC Collection"

func _ready() -> void:
	button.hide()
	npc_collection.won.connect(game_win)

func game_win():
	button.show()

func _on_button_pressed() -> void:
	pass # Replace with function body.
