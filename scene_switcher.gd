class_name SceneSwitcher extends Node2D
@onready var music := $Music;
const min:float= -60;
const max:float= 0;
var volume0 := min;
var volume1 := max;
var playing = false
var menutheme = preload("res://audio/menutheme.wav")
var maintheme = preload("res://audio/playtheme.tres")
var wintheme = preload("res://audio/winmusic.wav")
var losetheme = preload("res://audio/loosemusic.wav")
 
var main_menu = preload("res://Scenes/canvas_main_menu.tscn")
var explanation = preload("res://Scenes/canvas_explanation.tscn")
var game = preload("res://Scenes/Map.tscn")
var lose_screen =  preload("res://Scenes/lose_screen.tscn")
var test1 =  preload("res://testWorld1.tscn")
var win_screen =  preload("res://Scenes/win_screen.tscn")
func _ready() -> void:
	main.SceneSwitcher = self
func switch_scene(scene):
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
	switch_scene(game.instantiate())
	music.stream = maintheme
	playing = true
	music.play()
func win():
	switch_scene(win_screen.instantiate())
	music.stream = wintheme
	playing = false
	music.play()
func lose():
	switch_scene(lose_screen.instantiate())
	music.stream = losetheme
	playing = false
	music.play()

func _physics_process(delta: float) -> void:
	if main.belonging <= 50 && playing:
		volume0 = lerp(volume0,max,0.01)
		volume1 = lerp(volume1,min,0.01)
		$Music.stream.set_sync_stream_volume(0,volume0)
		$Music.stream.set_sync_stream_volume(1,volume1)
