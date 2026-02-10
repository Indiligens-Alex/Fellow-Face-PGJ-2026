class_name SceneSwitcher extends Node2D
@onready var music := $Music
@onready var sounds := $sounds

const MIN: float= -60;
const MAX: float= 0
var volume0 := MIN
var volume1 := MAX

var playing: bool = false

var playSound = true
var clickSound =  preload("res://audio/menuclicksfx.wav")
var walkSound =  preload("res://audio/steps.tres")

var menutheme = preload("res://audio/menutheme.wav")
var maintheme = preload("res://audio/playtheme.tres")
var wintheme = preload("res://audio/winmusic.wav")
var losetheme = preload("res://audio/loosemusic.wav")

@export var main_menu: PackedScene = preload("res://Scenes/canvas_main_menu.tscn")
@export var explanation: PackedScene = preload("res://Scenes/canvas_explanation.tscn")
@export var game: PackedScene = preload("res://Scenes/Map.tscn")
@export var lose_screen: PackedScene
@export var test1: PackedScene
@export var win_screen: PackedScene

func _ready() -> void:
	main.SceneSwitcher = self
func switch_scene(scene):
	print(get_child(0)," ",scene)
	get_child(0).queue_free()
	add_child(scene)
	move_child(scene, 0)
func to_explanation():
	switch_scene(explanation.instantiate())
func to_main_menu():
	switch_scene(main_menu.instantiate())
	music.stream= menutheme
	music.play()
func start_game():
	main.belonging = 100;
	print("starting")
	switch_scene(game.instantiate())
	music.stream = maintheme
	sounds.stream = walkSound
	playing = true
	music.play()
func win():
	switch_scene(win_screen.instantiate())
	music.stream = wintheme
	sounds.stream = clickSound
	playing = false
	music.play()
func lose():
	switch_scene(lose_screen.instantiate())
	music.stream = losetheme
	sounds.stream = clickSound
	playing = false
	music.play()

func _physics_process(delta: float) -> void:
	if main.belonging <= 50 && playing:
		volume0 = lerp(volume0,MAX,0.01)
		volume1 = lerp(volume1,MIN,0.01)
		$Music.stream.set_sync_stream_volume(0,volume0)
		$Music.stream.set_sync_stream_volume(1,volume1)


func _on_sounds_finished() -> void:
	playSound = true
