extends Node3D

@onready var terrain = $"../HTerrain2"

@export var tree_scenes: Array[PackedScene]
@export var tree_count := 1500
@export var terrain_width := 512.0
@export var terrain_depth := 512.0
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
	if tree_scenes.is_empty():
		return

	var origem = terrain.global_position

	var x = randf_range(origem.x - terrain_width * 0.5, origem.x + terrain_width * 0.5)
	var z = randf_range(origem.z - terrain_depth * 0.5, origem.z + terrain_depth * 0.5)

	var local_x = x - origem.x
	var local_z = z - origem.z

	var y = get_ground_height(local_x, local_z)

	var tree = tree_scenes.pick_random().instantiate()

	tree.add_to_group("arvore")
	tree.rotation.y = randf() * TAU
	tree.scale = Vector3.ONE * tree_scale

	tree.position = Vector3(
		x,
		y + ground_offset,
		z
	)

	add_child(tree)

func get_ground_height(x: float, z: float) -> float:
	var data = terrain.get_data()
	if data != null:
		return data.get_height_at(x, z)
	return 0.0
