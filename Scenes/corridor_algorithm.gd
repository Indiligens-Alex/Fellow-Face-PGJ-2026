extends Node2D
@export var save:=false
var distanceMatrix:Array;
var breakMatrix:Array;
var nextMatrix:Array;
const max_recursion:int = 5;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_children())
	if save:
		#print(1)
		#print(matrix.size())
		for i in get_children().size():
			var j:Array
			var k:Array
			var l:Array
			j.resize(get_children().size())
			j.fill(0)
			k.resize(get_children().size())
			k.fill(0)
			l.resize(get_children().size())
			l.fill(-1)
			l[i] = i
			nextMatrix.append(l)
			distanceMatrix.append(j)
			breakMatrix.append(k)
		#print(2)
		for from in get_children():
			print(3)
			for to in get_children():
				print(4)
				find_distance(from,to,0,0,true);
		var file = FileAccess.open("res://MapCorridors.json", FileAccess.WRITE)
		var matrix = {"distance":distanceMatrix,"breaks":breakMatrix,"nexts":nextMatrix}
		file.store_string(JSON.stringify(matrix,"\t"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func find_distance(from:Node2D,to:Node2D,num:int,recursive:int,first = false):
	var outputs:Array[int]
	#print("this ",from,to," ",matrix[from.id][to.id])
	if from == to || num>=max_recursion:
		#nextMatrix[from.id][to.id] = from.id;
		print("return ",num)
		return num
	#if  matrix[from.id][to.id] >= 0:
		#print("again")
		#return matrix[from.id][to.id]
	recursive+=1
	num+=1;
	var brcorridors = [];
	for br in from.get_node("breaks").get_children():
		print("next ",br.corridor,to)
		var output:int
		brcorridors.append(br.corridor.id)
		output = find_distance(br.corridor,to,num,recursive)
		outputs.append(output)
	var min:int = max_recursion;
	var next:int = -1;
	for i in outputs.size():
		if outputs[i] < min:
			next = brcorridors[i]
			min = outputs[i]
	#var min :int= outputs.min();
	
	print("from: ",from," to: ",to," outputs: ", outputs)
	var breakPos = from.get_node("breaks").get_children()[outputs.find(min)].global_position;
	if first :
		print("min ",min)
		breakMatrix[from.id][to.id] ={"x":breakPos.x,"y":breakPos.y};
		distanceMatrix[from.id][to.id] = min;
		nextMatrix[from.id][to.id] = next;
	return min
