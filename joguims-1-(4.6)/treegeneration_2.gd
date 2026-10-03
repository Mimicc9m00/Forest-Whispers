extends Node3D

@export var terrains: Array[Node]
@export var tree_scenes: Array[PackedScene]
@export var tree_count := 3000
@export var terrain_size := 512.0
@export var tree_scale := 7.0
@export var ground_offset := 0.0 

var noise := FastNoiseLite.new()


func _ready():
	randomize()
	noise.seed = randi()
	noise.frequency = 0.02
	generate_forest()
	


func generate_forest():
	for i in tree_count:
		spawn_tree()

func spawn_tree():
	if terrains.is_empty():
		return

	# Escolhe um dos terrenos aleatoriamente
	var terreno_escolhido = terrains.pick_random()

	var x = randf_range(0, terrain_size)
	var z = randf_range(0, terrain_size)

	var density = noise.get_noise_2d(x, z)
	if density < -1:
		return

	var y = get_ground_height(terreno_escolhido, x, z)

	var tree = tree_scenes.pick_random().instantiate()
	tree.add_to_group("arvore")
	tree.rotation.y = randf() * TAU
	tree.scale = Vector3.ONE * tree_scale
	tree.position = Vector3(x, y + ground_offset, z)

	add_child(tree)
	

func get_ground_height(terrain: Node, x: float, z: float) -> float:
	var data = terrain.get_data()
	if data != null:
		return data.get_height_at(x, z)
	return 0.0
