extends Control

@onready var start_button: Button = $"Start Button"
@onready var skip_button: Button = $"Skip Button"

@onready var label_3: Label = %Label3
@onready var label_5: Label = %Label5
@onready var label_6: Label = %Label6
@onready var label_7: Label = %Label7
@onready var main_character: Sprite2D = %MainCharacter
@onready var label: Label = %Label
@onready var label_2: Label = %Label2

func _ready() -> void:
	skip_button.hide()
	start_button.show()
	main_character.hide()
	label.show()
	label_2.show()
	label_3.hide()
	label_5.hide()
	label_6.hide()
	label_7.hide()

func _on_start_button_pressed() -> void:
	label_2.hide()
	label.hide()
	start_button.hide()
	skip_button.show()
	main_character.show()
	await get_tree().create_timer(1.2).timeout
	label_3.show()
	await get_tree().create_timer(1.2).timeout
	label_6.show()
	await get_tree().create_timer(1.2).timeout
	label_5.show()
	await get_tree().create_timer(2).timeout
	label_7.show()
	skip_button.text = "OK"

func _on_skip_button_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred("res://explanation.tscn")
