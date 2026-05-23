extends Node2D
@export var save:=false
var distanceMatrix:Array;
var breakMatrix:Array;
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
			j.resize(get_children().size())
			j.fill(0)
			k.resize(get_children().size())
			k.fill(0)
			distanceMatrix.append(j)
			breakMatrix.append(k)
		#print(2)
		for from in get_children():
			print(3)
			for to in get_children():
				print(4)
				find_distance(from,to,0,0,true);
		var file = FileAccess.open("res://MapCorridors.json", FileAccess.WRITE)
		var matrix = {"distance":distanceMatrix,"breaks":breakMatrix}
		file.store_string(JSON.stringify(matrix,"\t"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func find_distance(from:Node2D,to:Node2D,num:int,recursive:int,first = false):
	var outputs:Array[int]
	#print("this ",from,to," ",matrix[from.id][to.id])
	if from == to || num>=max_recursion:
		print("return ",num)
		return num
	#if  matrix[from.id][to.id] >= 0:
		#print("again")
		#return matrix[from.id][to.id]
	recursive+=1
	num+=1;
	for br in from.get_node("breaks").get_children():
		print("next ",br.corridor,to)
		var output:int
		output = find_distance(br.corridor,to,num,recursive)
		outputs.append(output)
	var min :int= outputs.min();
	print("from: ",from," to: ",to," outputs: ", outputs)
	var breakPos = from.get_node("breaks").get_children()[outputs.find(min)].global_position;
	if first :
		print("min ",min)
		breakMatrix[from.id][to.id] ={"x":breakPos.x,"y":breakPos.y};
		distanceMatrix[from.id][to.id] = min;
	return min
