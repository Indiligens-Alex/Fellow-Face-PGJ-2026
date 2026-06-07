extends "res://corridor.gd"

@export var pos:Vector2
@export var corridor:int

func _ready() -> void:
	main.corridors[id] = self;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
