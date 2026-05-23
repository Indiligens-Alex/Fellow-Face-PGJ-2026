extends Node
var belonging:float = 100;
var selected = false
var player:Player;
var SceneSwitcher:SceneSwitcher
var random:RandomNumberGenerator= RandomNumberGenerator.new();
var map:Dictionary;
var corridors = [];
func _ready():
	corridors.resize(3)
	var file =FileAccess.open("res://MapCorridors.json", FileAccess.READ)
	map = JSON.parse_string(file.get_as_text())
	random.randomize()
