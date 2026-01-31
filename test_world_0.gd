extends Node

enum GameState { Game, End }

var state: GameState = GameState.Game
@onready var player: Player = $Player

#if player is dead
# Game over
