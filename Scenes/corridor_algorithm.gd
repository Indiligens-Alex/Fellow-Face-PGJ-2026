extends Node2D
@export var save:=false
var matrix:Array;
const max_recursion:int = 5;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_children())
	if save:
		#print(1)
		#print(matrix.size())
		for i in get_children().size():
			var j:Array
			j.resize(get_children().size())
			j.fill(-1)
			matrix.append(j)
		#print(2)
		for from in get_children():
			print(3)
			for to in get_children():
				print(4)
				find_distance(from,to,0,0,true);
		var file = FileAccess.open("res://MapCorridors.json", FileAccess.WRITE)
		file.store_string(JSON.stringify(matrix,"\t"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func find_distance(from:Node2D,to:Node2D,num:int,recursive:int,first = false):
	var outputs:Array[int]
	print("this ",from,to," ",matrix[from.id][to.id])
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
	var min = outputs.min();
	print("from: ",from," to: ",to," outputs: ", outputs)
	if first :
		matrix[from.id][to.id] = min
	return min
