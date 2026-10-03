extends Node3D

@export var tree_mesh: Mesh
@export var tree_count := 1000
@export var area_size := 500.0

func _ready():
	var multimesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.instance_count = tree_count
	multimesh.mesh = tree_mesh

	for i in tree_count:
		var pos = Vector3(
			randf_range(-area_size, area_size),
			0,
			randf_range(-area_size, area_size)
		)

		var transform = Transform3D.IDENTITY
		transform.origin = pos

		transform = transform.rotated(
			Vector3.UP,
			randf() * TAU
		)

		transform = transform.scaled(
			Vector3.ONE * randf_range(0.8, 1.3)
		)

		multimesh.set_instance_transform(i, transform)

	var mm_instance = MultiMeshInstance3D.new()
	mm_instance.multimesh = multimesh
	add_child(mm_instance)
