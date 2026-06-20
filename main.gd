extends Node
var belonging:float = 100;
var selected = false
var player:Player;
var SceneSwitcher:SceneSwitcher
var random:RandomNumberGenerator= RandomNumberGenerator.new();
#from file
var map:Dictionary;
var tasks = [[1]];
#we add them in corridor/POI script
var corridors = [];
func _ready():
	corridors.resize(4)
	var file =FileAccess.open("res://MapCorridors.json", FileAccess.READ)
	map = JSON.parse_string(file.get_as_text())
	random.randomize()
