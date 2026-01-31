extends Node
var belonging:float = 100;
var selected = false
var player:Player;
var SceneSwitcher:SceneSwitcher
var random:RandomNumberGenerator= RandomNumberGenerator.new();
func _ready():
	random.randomize()
