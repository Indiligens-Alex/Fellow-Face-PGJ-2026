extends Node2D
@export var id:int;
@export var horizontal:bool = false;
var direction:Vector2 = Vector2.UP;
@onready var up = $up;
@onready var down = $down;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if horizontal:
		direction = Vector2.RIGHT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	up.position+=direction;
	down.position-=direction;
