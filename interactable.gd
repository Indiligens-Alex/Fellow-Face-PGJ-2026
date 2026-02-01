extends Area2D

var interacting:bool = false;
@export var changeClothes:bool = false;
@export var clothes:String = "";
@export var texture:Texture2D;
@onready var sound := $AudioStreamPlayer2D

func _ready() -> void:
	$Sprite2D.texture = texture

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$Sprite2D.set_instance_shader_parameter("active", true)
		interacting = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		interacting = false
		$Sprite2D.set_instance_shader_parameter("active", false)

#func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if interacting && Input.is_action_just_pressed("interact"):
		#interact()
		#sound.play()
		#main.player.interact()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if interacting:
		sound.play()

	if Input.is_action_just_pressed("interact"):
		interact()
		main.player.interact()

func interact():
	if changeClothes:
		main.player.changeClothes(clothes)
		visible = false
	print("interacted")
