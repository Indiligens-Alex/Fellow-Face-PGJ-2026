class_name SceneSwitcher extends Node2D

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
func start_game():
	switch_scene(game.instantiate())
func win():
	switch_scene(win_screen.instantiate())
func lose():
	switch_scene(lose_screen.instantiate())
