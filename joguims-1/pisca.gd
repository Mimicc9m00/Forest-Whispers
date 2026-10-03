extends CanvasLayer

@onready var som = $"../respiracao iniciaç"
@onready var tela = $ColorRect
@onready var world_environment = get_tree().get_first_node_in_group("world_environment")
@onready var camera = get_tree().get_first_node_in_group("Camera3D")

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	abrir_olhos()
	som.play()
func abrir_olhos():

	tela.modulate.a = 1.0

	var camera_attr = null

	
	if world_environment != null and world_environment.environment != null:
		var env = world_environment.environment

		
		if env.has_method("get_camera_attributes"):
			camera_attr = env.get_camera_attributes()

			if camera_attr:
				camera_attr.dof_blur_near_enabled = true
				camera_attr.dof_blur_far_enabled = true

				camera_attr.dof_blur_near_amount = 1.2
				camera_attr.dof_blur_far_amount = 0.8

	var rot_original = camera.rotation

	camera.rotation.x += 0.03
	camera.rotation.y -= 0.02

	await piscar(1.4)
	await get_tree().create_timer(0.40).timeout

	await piscar(1.0)
	await get_tree().create_timer(0.30).timeout

	await piscar(0.8)

	var tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property(
		tela,
		"modulate:a",
		0.0,
		2.5
	)
	if camera_attr != null:
		tween.tween_property(
			camera_attr,
			"dof_blur_near_amount",
			0.0,
			2.5
		)
		tween.tween_property(
			camera_attr,
			"dof_blur_far_amount",
			0.0,
			2.5
		)
	tween.tween_property(
		camera,
		"rotation",
		rot_original,
		2.5
	)
	await tween.finished

func piscar(tempo):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		tela,
		"modulate:a",
		0.55,
		tempo * 0.65
	)
	tween.tween_property(
		tela,
		"modulate:a",
		1.0,
		tempo * 0.35
	)
	var shake = create_tween()
	shake.tween_property(
		camera,
		"position:y",
		camera.position.y + 0.03,
		0.15
	)
	shake.tween_property(
		camera,
		"position:y",
		camera.position.y,
		0.15
	)
	await tween.finished
