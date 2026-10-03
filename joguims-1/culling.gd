extends Node

@export var camera_path: NodePath
@export var distancia := 80.0
@export var angulo := 100.0
@export var intervalo := 0.2

var camera

func _ready():

	camera = get_node(camera_path)

	while true:

		atualizar(get_tree().current_scene)

		await get_tree().create_timer(intervalo).timeout


func atualizar(no):

	if no == null or camera == null:
		return

	if no is MeshInstance3D:

		var vetor = no.global_position - camera.global_position
		var dist = vetor.length()

		if dist > distancia:

			no.visible = false

		else:

			vetor = vetor.normalized()

			var dot = clamp(
				-camera.global_transform.basis.z.normalized().dot(vetor),
				-1.0,
				1.0
			)

			var angulo_obj = rad_to_deg(acos(dot))

			no.visible = angulo_obj < angulo * 0.5

	for filho in no.get_children():

		atualizar(filho)
